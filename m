Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2376CC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E547861948
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E547861948
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A6C6E9AC;
	Mon, 17 May 2021 14:40:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C266E9B0;
 Mon, 17 May 2021 14:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKWLMC0cljeYxSnWsWp7OKld0pN/Dl8bRbEbN60gcARA+gbd54eKphfKdoYHHPOxLYpnH5yePtE/yz1PxKx6cRc7eFY3U3I1oarXVp8wvglfZxOsxF1xzWam+p+wXxZMAimn6NvgdE2P1YwJ5yQwyGWf7j8tIAh+FtSJZeoXgCBZkKPETuA6Bx6IGfxuwRVJteO7ZrntLHmd0nd9/pnAqzPSLu6c9FRSGF9DY2WrhFNvShh32dT0vkXYGB/ysuYagYou28i/tVYkSnK1FpO/BWKcahLJnAvctr9LoRXy2YfKtDcjTi1HtnDreiG+y/JlksdXLIp7WEBsgCdDAse1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjXTbGZ3gYkr/jh9+KmS7wkM3nZmZHhG1A6NergEp44=;
 b=bz5LRocg6dhvhwozp1yoghcxV/CcT2Wtm4pVgiur2X5+ZSFQbWePV8Rv1I6CV7EWBS7lveK+j5v8JtMCfKyKxdpxm4R4cY3tXxpkGzbd6XRrGMqSXOOHpKuvahu9MdS67B7OD8dJ/d83FazV0SPRM79IQ0yFe1RTyu1D4PV4o8YTX4G1Iomi7vfLsOLyyH16xVkj5JX3bnYfiuov5jkddbBPrjjKqLquQXMIKVm1gxgwlSzDecmXG6veXonEN9u2w6q0c1tnVbiO1TF2QNIS/IcQ7J1D31h1nFhHseXboaqQKRCgxzLor69uiBxlIkH0ROaeK+HknDAbsyYMBDZSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjXTbGZ3gYkr/jh9+KmS7wkM3nZmZHhG1A6NergEp44=;
 b=IB6CRDcs9AZQyzlRMXjfcBdCQSwsF6BhsepKn/g6Cya/mdF29zjLnRx4JyI530/9aILZZf75lihkHfyaV5xTcBJD6ohCUYwek8W6DDyhW9RHPyljwxiRSK1X08DWKbRXumSlGq4a1A7q4PFTnqOWw19A2Wohr9KIsZ6rnw/BX7A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4766.namprd12.prod.outlook.com (2603:10b6:805:e2::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 14:40:52 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:40:52 +0000
Subject: Re: [PATCH v7 12/16] drm/amdgpu: Fix hang on device removal.
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-13-andrey.grodzovsky@amd.com>
 <0e13e0fb-5cf8-30fa-6ed8-a0648f8fe50b@amd.com>
Message-ID: <a589044b-8dac-e573-e864-4093e24574a3@amd.com>
Date: Mon, 17 May 2021 10:40:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <0e13e0fb-5cf8-30fa-6ed8-a0648f8fe50b@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:e3b1:83be:2b02:85cb]
X-ClientProxiedBy: YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::17) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:e3b1:83be:2b02:85cb]
 (2607:fea8:3edf:49b0:e3b1:83be:2b02:85cb) by
 YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 17 May 2021 14:40:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 077573b5-9f16-4d9c-189c-08d91941c571
X-MS-TrafficTypeDiagnostic: SN6PR12MB4766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB47665D81B0E5F68B4B9FC372EA2D9@SN6PR12MB4766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKexWhQpOv2TNjQU2451b4n6EKY7UJRghGwv0flXE0g14DGIUaoiFgiiQCnBgS3WIDYRxZM8JQWHN/iHxJ1xnS4zB5VF6SLXe1//NlfgACvPs9U6ebcUvuUWDuwXk+E/+Az0WmnLsSLv3wEezGTEWRDTVbRJ6lEhBIgkFFnkFWnYdTeicsJ8W8C79KrqvOTGLdoSbljvHo6cA6Rl2dzF46NX1ufU6vzrpLWmKcscrDKasYfNko+Ao24TskIhWfocTbOPjwfTIyvmz4GMF3w2Z/EzO9WXc3xWaZKe9NV/hTEdzHJItnEktRVOIR/2HtAb73hpu9ZLBpyYWjicQoMdu2Bf1Tl2zkEGBOHghePxNyOmTrz2WKKqd7+tsJaHSqBnOt6TQELEVlGq3EIT/mlPlUJy+TT8EKzLwh3MiCDuj7tf5AuoKMeEgxAA1JG15/6DmFIV/WFiCPygoAuNIypn1sgUt8NjGpXNLJolQ/+dsf8Fg7aMJom0cNbFVqrnBfRNWC9Uz6J0OuCIdED6Xl4wkxq7pQZSqrJoehLpXXySUJLYigA/zjLgmhmUvQ6T9vDXOkmQWoTH8FTP32jfhuqx3i4vX1KnyDLgpEBeDY6hqTVkRSQtr1cj58RSWUaOtjv/JKeyTw2mYJ7GjD/akKiGsaxV+oWg/zV4RYDlIWKLlcjvFEThxPcPYZSpPLX3fFng
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39850400004)(366004)(136003)(6486002)(31686004)(66946007)(52116002)(4326008)(53546011)(31696002)(186003)(8936002)(8676002)(2906002)(6636002)(83380400001)(5660300002)(316002)(38100700002)(86362001)(2616005)(16526019)(66556008)(36756003)(44832011)(478600001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M0hyYkUwZXpBSlFoUGtGeU15c1Z0OTB4cHhpQjYvYXh2aU1vTGt4ekZBNVU0?=
 =?utf-8?B?emgvZy9kQzNwRituV2NFQzJLcTBSTXJDM0hCaElPSlJYYUQ0YTFKWjk5SHFE?=
 =?utf-8?B?a0M3R3Y5cXpncUhTeko0RXMzdXg2a1V4SXJlT3NLRzJxRkpOZHlPN0l0OGVT?=
 =?utf-8?B?c1hVRWl6OXdrbC92RTM2NzlLb3hldUR5TlptelBoMFljOFpjdzgxTlpvWE02?=
 =?utf-8?B?YmZWY1VuM0VKZWlNRWU3V3NiMjBaU1RkMkp5KzRGaGdXOUJKOGswam1mb0x0?=
 =?utf-8?B?OGZKSkMwb2tHdUVCTnFaRDgzN1poQjlsWTdnblRhWnloUUJqVGlRMnNMRjJW?=
 =?utf-8?B?SE56ejhURWUrcWFUV3VqelJyc1hYTEZWSDlnMHFTVlhqS3NhK0RpZ0I0K2Zh?=
 =?utf-8?B?SzNrNFFaaTV5U25kZmgwTTA2aTFwSmpVa1ZmTGdtVnJKSVNSQ3htbkhlaFgz?=
 =?utf-8?B?VGdHL0JXdVdZRHZlamd3cDMzRnN2Y1ZHek9FT3pOdXlNSFN6M2hKSE5yRWtp?=
 =?utf-8?B?eDM0Szg2ZUZhSnZFYVdmRk4yd1RmQUJubjZMeVdET0JZU1JlN01ieTQzdFBS?=
 =?utf-8?B?MkVJU2NSY2VXSCtHV3hPK0hYRFc2azdhWnZ6Z3BCMWk0NzZ6VHI5VGY5N3hN?=
 =?utf-8?B?ZmdVb0ZJMHJDdUwybDl0S0h6Q1NYRmYvYWQ5dmpGc0o5cWtEdjZkdTRHVHVa?=
 =?utf-8?B?Q1FUYXJtUnVzMThRWEJTL21rUzBFRnQ3U2VWL251UnZYdnlqV3hWUlF4cXpp?=
 =?utf-8?B?dDVhQWx4YXV6WkFvNXBJQXdtbXUrYTNmNXRNRWZpOGJ2QnJCa3VhaG41d3ov?=
 =?utf-8?B?a1pmU3RtQ0szSTUrQXc3cXVnRnVaSkJMdTVpRGRrdG51Y0R6VW5yRjBUTnc3?=
 =?utf-8?B?Szdqd21HTG5YWm1OUlRBdlIyS1IwaWtwQUUzSnh4YUs2R20vMGNmd0ZrNFp0?=
 =?utf-8?B?dXk1dVlKc3owZHZkWlpBVTlBWjNzK3BQeWszbmk3dkt1VEhQU01leWlIdlI2?=
 =?utf-8?B?M1lHUU9zZGxvUkdQM2ZxZHF4Y0hkbEd5VHFYSG1pZG80R1dHY2R4K05tWVFD?=
 =?utf-8?B?U1AwUkJFWHhlS2pNcElsOWhxL2RMbjJjanN3SXNRbk1vZzIxd21aTzg5eVNW?=
 =?utf-8?B?YUhKUXNicWhJd3FUQXdkSVBYZnl1dGRXZXFVZTRnNXE3d0lxcjl3UlhEd0hh?=
 =?utf-8?B?VDVnNkgxYUJBSkQ5WElwdStVRGJON2VVUlZIZFY4MnZTWkJVTERIamgyb0NP?=
 =?utf-8?B?T1ZxVjNuYStQS0hxMC85MWREZTJSWXd1MVA0NCt1Z0MwY1BZa2NuRDlUUXBq?=
 =?utf-8?B?WDdBQms1SUVtNU1VUUhFMVhFV2Q0V3A2Nnc3S1VTMEIvU1NsZnFHMXczOXlH?=
 =?utf-8?B?bXZiVDhsb2hyZzZZakF0QU9welFlN2hHZzRLd1lyZktuMVdNWjk4RGdtUUtJ?=
 =?utf-8?B?WjdXNTE5L1FlOXBKeFp1eE1zQkFuSkx5d1I5ZDZVdzl2eTgzNDdOT2FIYzdS?=
 =?utf-8?B?bVZEQXNJOFYzSWgvQ2xuSzlHZ1RxMEg0VHVPME5Eby8vYlJyVDFxRWRscERa?=
 =?utf-8?B?S0s2SzJUd0Z3SDluUjZ4VzJveUVhOGFtSDc0R2RTaWdpUWJ0WURZVGNrSVlp?=
 =?utf-8?B?K3JXWG5VaWdvQ1B4Tm96ZmxCWUJpUmYrWTZtWm5HcENpTjlvTVZxVUF5c1lv?=
 =?utf-8?B?L001S1FGUjFkM2JCTGZIajlIK3VmUHc0RGxzbmdIMlFMZmo2Yjd2UW4rUXpX?=
 =?utf-8?B?MDJVYjY5cTc1UXIyN2UxUXVxVmlaVG5Rd0FBWm5RcnFhRDFoa2dnQ3dBZHFJ?=
 =?utf-8?B?YzV1Q21OeitzZm40M1pKOUdjMDR4K2YyOGovTDg5RElRMksrRWdGNGVQYUtL?=
 =?utf-8?Q?Jf22nGV0AX4k5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077573b5-9f16-4d9c-189c-08d91941c571
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:40:52.7506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/9BdR7p6oXx2fIMSUn1rykZT8tm9OvphMXxtG93GTEkHWyx3hhsEvaq38qafoqHjASt5DgUi5EwYN/q4eugWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4766
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZwoKQW5kcmV5CgpPbiAyMDIxLTA1LTE0IDEwOjQyIGEubS4sIEFuZHJleSBHcm9kem92c2t5
IHdyb3RlOgo+IFBpbmcKPiAKPiBBbmRyZXkKPiAKPiBPbiAyMDIxLTA1LTEyIDEwOjI2IGEubS4s
IEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+PiBJZiByZW1vdmluZyB3aGlsZSBjb21tYW5kcyBp
biBmbGlnaHQgeW91IGNhbm5vdCB3YWl0IHRvIGZsdXNoIHRoZQo+PiBIVyBmZW5jZXMgb24gYSBy
aW5nIHNpbmNlIHRoZSBkZXZpY2UgaXMgZ29uZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5
IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyB8IDE2ICsrKysrKysrKystLS0t
LS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVu
Y2UuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+PiBp
bmRleCAxZmZiMzZiZDBiMTkuLmZhMDM3MDJlY2JmYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4gQEAgLTM2LDYgKzM2LDcgQEAKPj4gwqAgI2lu
Y2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+Cj4+IMKgICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1l
Lmg+Cj4+ICsjaW5jbHVkZSA8ZHJtL2RybV9kcnYuaD4KPj4gwqAgI2luY2x1ZGUgImFtZGdwdS5o
Igo+PiDCoCAjaW5jbHVkZSAiYW1kZ3B1X3RyYWNlLmgiCj4+IEBAIC01MjUsOCArNTI2LDcgQEAg
aW50IGFtZGdwdV9mZW5jZV9kcml2ZXJfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4gKmFk
ZXYpCj4+IMKgwqAgKi8KPj4gwqAgdm9pZCBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHcoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+IMKgIHsKPj4gLcKgwqDCoCB1bnNpZ25lZCBpLCBq
Owo+PiAtwqDCoMKgIGludCByOwo+PiArwqDCoMKgIGludCBpLCByOwo+PiDCoMKgwqDCoMKgIGZv
ciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdTOyBpKyspIHsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IGFkZXYtPnJpbmdzW2ldOwo+PiBAQCAtNTM1
LDExICs1MzUsMTUgQEAgdm9pZCBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHcoc3RydWN0IAo+
PiBhbWRncHVfZGV2aWNlICphZGV2KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250
aW51ZTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghcmluZy0+bm9fc2NoZWR1bGVyKQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcm1fc2NoZWRfZmluaSgmcmluZy0+c2NoZWQpOwo+
PiAtwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHJpbmcpOwo+PiAt
wqDCoMKgwqDCoMKgwqAgaWYgKHIpIHsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogbm8g
bmVlZCB0byB0cmlnZ2VyIEdQVSByZXNldCBhcyB3ZSBhcmUgdW5sb2FkaW5nICovCj4+ICvCoMKg
wqDCoMKgwqDCoCAvKiBZb3UgY2FuJ3Qgd2FpdCBmb3IgSFcgdG8gc2lnbmFsIGlmIGl0J3MgZ29u
ZSAqLwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFkcm1fZGV2X2lzX3VucGx1Z2dlZCgmYWRldi0+
ZGRldikpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSBhbWRncHVfZmVuY2Vfd2FpdF9l
bXB0eShyaW5nKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgciA9IC1FTk9ERVY7Cj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBubyBuZWVkIHRvIHRyaWdn
ZXIgR1BVIHJlc2V0IGFzIHdlIGFyZSB1bmxvYWRpbmcgKi8KPj4gK8KgwqDCoMKgwqDCoMKgIGlm
IChyKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZmVuY2VfZHJpdmVyX2Zv
cmNlX2NvbXBsZXRpb24ocmluZyk7Cj4+IC3CoMKgwqDCoMKgwqDCoCB9Cj4+ICsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChyaW5nLT5mZW5jZV9kcnYuaXJxX3NyYykKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2lycV9wdXQoYWRldiwgcmluZy0+ZmVuY2VfZHJ2LmlycV9z
cmMsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
aW5nLT5mZW5jZV9kcnYuaXJxX3R5cGUpOwo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
