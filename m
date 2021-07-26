Return-Path: <SRS0=1/L1=MS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6E3C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 04:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC02606A5
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 04:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FC02606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5006E58A;
	Mon, 26 Jul 2021 04:12:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BD66E58A
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jul 2021 04:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd8vSd8RA3kfTB0GQmMYIxVkf3V0zyVhwC6bOtM9F+CMXbQcsC1o4wHVsmX+motf6Pb8bAy4kZbIK0j7XPggE/gPGrzMC6KWu1SuSj7DZLw1mKyJn/BImoxoLBYf5I3cYDZwyNsoee5XpKoAqU8HTXouMY3ofK4hi6vn/9H6m3VSwPErf8Iag6LUnqUCQ5J5CsAv60ryE+QUyB/y1Gdi9GxBUae8Eh/qzl8HkLZvU5y6j8pjLgp/pc6DBA0Vcnfq3coy+PIkdSrnqY32qW5fb9DGBdOv8fRUEjB4+nBhKvClVmy/Ye3BbVSJmwul0B1e7ygM6/y0tOqEbEkFUQaB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qx8hgO//GEcQB5nkD6ZkKkHqu2U8sKjpS9cxtXBTD4=;
 b=jOu6FO4wzXUm2ycKPhgCsK+du2H5Xh0ToYwwuBf8Ji1iZHZwPqsqPFlDFMhBLb7Vrz+Ej3An6t9MJF7OP/57McInJ0KVuVT4yBL0OdXOytbU1pSBmvRb6mL+cF+4tc8hMaDScW7fiXuWU/QcwdzdvQLv5zJA38MDAM7W3ao+ieg0fULLNNw3+wQEDQaJtmxQBHwN+BPK7rMX3KOpMdIUznM17wVBx6Iz9nwJZ3ebpd7T8WAxZpGwXImPs1nRdMfpLKHiyXBoRjZ9Oiy2Mr6WRUCZ9m1RsHAjOQ1Fc1XsTCIJ9O9xFkii6fKqF1/S6kT5inbJstv21RH+aArnXRqUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qx8hgO//GEcQB5nkD6ZkKkHqu2U8sKjpS9cxtXBTD4=;
 b=M+PD7jCh1W8oTqT4/aSEGWcQQuaaOsC3hZ91+FMEVF1CztbZPcFvWnXNn9/0i+nHfD3M32NTRtKGgifBtyCr9o7YXsSetrppEYwSJ2tb38f3VznZHNI3dPx4eterilHC/Xuny6TC8oGuPL9YxSLhu/rEWspFLYIbkr3T6bxGtx0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Mon, 26 Jul 2021 04:12:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 04:12:54 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Topic: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Index: AQHXfqifeeLDV50fl0aVa8y8c1VYEatQ/U8AgAOtrJA=
Date: Mon, 26 Jul 2021 04:12:54 +0000
Message-ID: <DM6PR12MB2619BD04850986461A5CA17EE4E89@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210722032046.767094-1-evan.quan@amd.com>
 <9e502775-bf10-6b0d-116d-1159d674e11b@gmail.com>
In-Reply-To: <9e502775-bf10-6b0d-116d-1159d674e11b@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-26T04:12:48Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9acf441e-fe8e-4852-942a-5507f76dec02;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94b5abb0-9ed5-4240-67fa-08d94feba47f
x-ms-traffictypediagnostic: DM6PR12MB4372:
x-microsoft-antispam-prvs: <DM6PR12MB43720E9E72AC612822C8A944E4E89@DM6PR12MB4372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDMGtdP57gYAJKaz2cfuYUWFjYKirzdrk/kcbxtV+g37Zt7ibN9fsjiftRl5mC7tsOzuahxUIeRewyLcT6pxD9knwLdSIh96WKH+Y4e2p/n8RzvH+wsPFauQspNRsepXAPEdaKU+lMjSjz3SX5+mh1b0BJQ4Yq0ewR2hYuEJnlT6K4AIr4uK24ZzI29cc4SHhpS1OsqTMBnadgCznSIhuE5OYgCmNj7qdT+y/CCVHOhV6UdLRrI+rRRL3sKTizomo326YL3zGC9iYYjdEN3CLA8kh5Nc2YCL1wBnt0fh0kD3hHHc5cC1BxTj931Kg4UnkW+ftw2S3MKsgCPpsqD8SQoeb94+zonmtphjLSZPATXDPjiOl1/Hn5g+g9xKZN0hCP4X17/1GhxS5ht5MxsxnHWtuiQ1Bnff3jZBUOHD3HhAvXAfTS5ZpIx+kgukdttyAt4W7UjouzSxrtA7AlfEF8JSAmg0YU2xd08PREPr3zsZa53Rh1HvyLG5oQrxvH0CgwAMIs8jdEb3oOAofBf9QYrog0ODmrfFGVi0ssMYRpL0b8RIJwtjR4QEEZ0Nm7MPn0hqStWTH4XGVjnEJ2uAlBds2GDrvv7XaMd8wznkMmFXFEMl/dnYEhivkbQS7nA3TifQjNs1mvFt7L7hbqbV69NbiPc1dI/0SNoP7OnxJLJrPs+CPou1+EU5pd+QMHkGHaFQ4Mr55jV03xa+r4pAJM/y8P7PvwFuHeQeUNF8cOE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(122000001)(7696005)(33656002)(86362001)(52536014)(83380400001)(38100700002)(71200400001)(26005)(6506007)(53546011)(2906002)(186003)(8676002)(4326008)(6916009)(5660300002)(66476007)(64756008)(66556008)(76116006)(316002)(478600001)(66446008)(66946007)(55016002)(9686003)(8936002)(32563001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1NUeFJBRXJqYUJrWDF4VmgwcmxEYjNQYkZNVFhKODZBbFdLSDlHZzlYemJl?=
 =?utf-8?B?TU1LWjlJSHlMVndXN3JnWWJFeDA3SzdMR280bVN4S2lFa21jd1ZWMnJmTm9j?=
 =?utf-8?B?MWhhK3FOajEyU01NOVR3SVNqVkxvVWw4MmNxRkZsVUY1YkhZMkNXTjUvWlFU?=
 =?utf-8?B?VHJLRzBmVzlVWHhocUlJUGJXRlZ2YStTWHdkdm5iMlVHRldiRFBLaTBMc1BD?=
 =?utf-8?B?ZVZycDNGV0NCQkl0WEMvMktpMnhobUh5K0tPZ2JmeGhJeHlwVzRTTDFBMzN1?=
 =?utf-8?B?OXBnNndQSVdDOUI2L2JUT2tWYW1UTTlHS21jUGtuY1I3OUE1N1Z0VkZLdUpn?=
 =?utf-8?B?ZnhZV2I1SWVZeFc5VDE1ejZVSXA1aGdWRjgvcmt1V21WNU5xUDJzM2Yvek8y?=
 =?utf-8?B?ZEo3UGZCQlFPVlZta0grSzhMOURNVGsrRm5OeFl0bmpqQ2NVY3g5a1BSM24x?=
 =?utf-8?B?VjM2aGNDdWR0UnhBME40QXpqenRyTXI1Z1IzVzQzcWNGQ25TbE1NQmJwSGhG?=
 =?utf-8?B?bldnSUttanlMaHFnbjdZU1hTc0RRNG1YdmJ2SmZGVmljL0h2bXhXMTA1dHY0?=
 =?utf-8?B?cEwwa2JsNXF0ZGpqQS9VV2ZxZEtkdFRxSnVNaGh6eXA0OVJ5Z0F1WkJCbS9o?=
 =?utf-8?B?dWlrSGxPNkhRUTU4Ukpob3BhT0piT0tjRTBycnFhOXFYS1VjTjM2S2RzUlhi?=
 =?utf-8?B?RWNMTVdZeGRIRE92UEZyVlBQNnJGdDZNUktqcHNtUGRzdnVPQzZzdUlnc3Zm?=
 =?utf-8?B?MFlhSmZvdWpqMlMvVThMZUFXVXp5MUwzam5xazM4QkFXRFJneW5lRWZPMWFs?=
 =?utf-8?B?UU9IYnJydDlGUHowQkxWQXozcUV4NzA1MllzcjZMWVpMdnFWazVJZGVDd2ZV?=
 =?utf-8?B?dlpMNlo3cWtQVjJJbFpWVzVYcEJudEZSZmx5THhiWnBkMDZ1bDk5d1NPWXpL?=
 =?utf-8?B?Zi9LOEVPOWxtS1NUQ0c5L2pTL3lKYVh5ZWNvS0xRSnZrU3RnTzA0TXhNZ0Y5?=
 =?utf-8?B?UUlkVkk0Yi94SjIvMzl4MDlEZytyL2xYY2hHT3A0ZjFGeElQc1FaTnA4VEhs?=
 =?utf-8?B?RVF1eFAzbFovSTRHS0JQditWUmoxcnJnbHRkcG1WTzlvWmtWVnIrK1RJNGZE?=
 =?utf-8?B?NS9PenhDTjNMQXZpS3QwSGdLYWlMdEozbnRCWWloejlIMjFnRUhuMHNSK1Ft?=
 =?utf-8?B?UHgzaFpsTSt5UVl2ZWcwZjFOc3luSmhQTk1CUkhsdlB2ZEliNi9JUXVPSXRE?=
 =?utf-8?B?YWRhMzRDWEhuYjhUS3czcElQQVBjNUJYNkxMR1p2OGZ3aGFEdTFqRWZ6aVFN?=
 =?utf-8?B?cmJuN2dKa3RJUXpmZlcvZnk5QkE0U2lhdzMwU2t6ZS9pZ1FTYk9QNDNRVzhF?=
 =?utf-8?B?dGp6bGd1N09UZENpbVBMMFFBcWNzaVJ5Nk5iazRycVNMeVVhLzJSR2NEdHlv?=
 =?utf-8?B?ZDRJR2lEcWkwYlkvUXVOYnAwSmhTVWpVVFFFS1QxL3dpaGR0T0F6S3gzdmJ2?=
 =?utf-8?B?eVR5a2hsMkxQeVRJdXRzbTF3UVVkMjdBSlVkSEpmMkg2cnBaaHFTaDU0OGV2?=
 =?utf-8?B?SkZrTkoxRkF3TXVUT1pOYUEyZzltQ0hkcHZpcjhSQkNKZlJWWEVGYW9jVXJs?=
 =?utf-8?B?UWNrd1BzMzBubmsya3FOWlZIcENFWVZoT1ZsNTdGeU1tVXNnaFlvaFZxNXYr?=
 =?utf-8?B?NkgvTWF0MzljZ1JrL3plemQ5QVpSWENnemZnOWY4aHV6K1FLTUo4RGxBTGlt?=
 =?utf-8?Q?JoD3fZQqj9G0xywQgOHj/5YJSsFmJEy99Tj353U?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b5abb0-9ed5-4240-67fa-08d94feba47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 04:12:54.4238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2Kn7i41HM7Tu924dVOZXuI7FW6YuJ/hM+Ic6tnB7Ocl8k2tlG2xiadAvkSsJTR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks for reminder. As I confirmed, the OD settings will be reset to default after gpu reset.
As smu->adev->in_suspend is 0 during gpu reset. And that will reset OD settings to default.

BR
Evan
> -----Original Message-----
> From: Matt Coffin <mcoffin13@gmail.com>
> Sent: Saturday, July 24, 2021 4:00 AM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
> properly for NV1x
> 
> On 7/21/21 9:20 PM, Evan Quan wrote:
> > The customized OD settings can be divided into two parts: those
> > committed ones and non-committed ones.
> >    - For those changes which had been fed to SMU before S3/S4/Runpm
> >      suspend kicked, they are committed changes. They should be properly
> >      restored and fed to SMU on S3/S4/Runpm resume.
> >    - For those non-committed changes, they are restored only without
> feeding
> >      to SMU.
> >
> > Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> 
> It's been a while since I've been through the SMU code so I don't know all
> the places that restore_uesr_profile is used, but, just to confirm, these
> would still go back to default (boot) values on a GPU reset, yes?
> 
> I ask because when pushing OD settings too far, GPU resets are often
> encountered, and you might be able to create a state where it would
> continually reset if your OD settings are remembered even through a full
> reset.
> 
> Very nice feature other than that, though, as I actually keep `radeontop`
> open in a tmux session to prevent my secondary card from resetting my OD
> settings, so this will be nice.
> 
> Thanks for listening, and for the driver in general, Matt
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
