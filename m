Return-Path: <SRS0=9dkd=HU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C88EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 10:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0552160235
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 10:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0552160235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7736E3FC;
	Thu, 18 Feb 2021 10:11:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D8B6E3FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Feb 2021 10:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meQHWV4UueXNcnh2EWoBxEy9YtgigFqkL0bYmyAssbyCPVtNDKGIiFFD6i1jCmnch6fQjzUtbLjEh5AeMg5SBXidBPa/DDuiVMikdcCJggrupaYiTeT3qOqXGNO1eKIsmULV3dPds5CQP4E4ocrz1O6i8Nkyuz4Crs/PlbMoPoZnluga5LGl/xDC69fZPTkEn1yxJIvadKTFACP99cXYME6woX1iYWWmsXaADLcCHFLb1iiYDlxbChRlhATNCJjN6lNYh7/X2SkH071pQIKehTKOBmssQv4PTSieD4qvvA/Hom3Gw6+EYuOkrFyTdgw/BVYz/fsJd4NN39+SXy2o5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzpEe8awl6pjPM5pKTUjoWX8DPf0G+/ZcAMGTm1Bh/s=;
 b=Js2+CvvaTnqm7WQSTtZ/FQSxZGp/00zCfL5J4PyDXeqapJ5L2btdv3gvgoQq8YKEcjCnAC/OisuchdA41N6Nyrj6qEh2Ma2GNMfwW+xjpI1pxZ08OgLQx6QXYbyE+YmLWI4Q5HI4TRStuiZ+mKQWMbX2sLVuo6kbiTIE8QiCvJwapT6vuObXFZThBL4X71Pxx9ZG7yXge/E+NwsVpjsI0t3S9rje/H8Er7JYETREUQklRExCdzjFK0GrhwSycT686XLNmdnjlV0YEecibGjmu/ryY7OEIx5SVJcv1cChKbq5e0rXlYR9zJrVy2qwrMSlEVFzdfh56gNtfAsR+gxj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzpEe8awl6pjPM5pKTUjoWX8DPf0G+/ZcAMGTm1Bh/s=;
 b=XtE2ihFjyYeAYMKBolOROYA2pbwJQ+V3jxz7AJwWaHpJwMok+1QmY3Hcwh9XM/zLJr40lYEtNcxcyKRrasFGqi4UnZnlYZAZn9LDWLyzgwMco+2fNs9C/7gMRehG4SIaOPPxPS82tvPV2o5C4Vs2ZzjyJkQ0OwjAS96q7wXKAYE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 10:11:53 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::b877:1da1:c4d4:6235]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::b877:1da1:c4d4:6235%6]) with mapi id 15.20.3868.028; Thu, 18 Feb 2021
 10:11:52 +0000
Subject: Re: [PATCH 1/8] drm/amdgpu: new resource cursor
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ramesh.Errabolu@amd.com, amd-gfx@lists.freedesktop.org
References: <20210217190028.16409-1-christian.koenig@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <84622ece-8fdc-8691-6b65-701601ba59cf@amd.com>
Date: Thu, 18 Feb 2021 11:11:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210217190028.16409-1-christian.koenig@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.118.212]
X-ClientProxiedBy: AM4PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:200:89::31) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.118.212) by
 AM4PR0202CA0021.eurprd02.prod.outlook.com (2603:10a6:200:89::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 10:11:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ed8b26a-2a2d-492d-ae22-08d8d3f59cdd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44203E9BD994D2E76157FF7F8B859@DM6PR12MB4420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUp8kAzUpVtm1wolkTX4/Y37XLzyJsjIDtuwmcBw0u1EvlpPzlNWtBSNKwnbau/mOka9DeBvPB2Cowz2QmjIMWXXOKbfpYqjRcHVE3T3qhDn/UZWMnt3dlmcfbvpR7VUa09uPZmKRKtFPOyE0uzeUxElJBhayZMvzPfvD/SLJkAUD5ngUcuPdYprf+53u9SJbyC0YGHHYYVqoigMnnuz2b9LHu8TSIfAD3ZqKyggAatwx9Lx71a+TM6pvn4pkvDqvnnz2WZbc8TvmRCBqr/cyUB0tp0IUT21yOtqDOrWZNV3x4+rYpy4S8wkEHl9l3ORlXRAj4L6bu9byY8mU7qPVVd00pvl4WLlYty8HAOVw9tQA6T3ipkzslOxjIZiV8dUetJ3e9SJETtMbQzZX1jgLf/e5BoCj0f7OUIJ65jjCwlnOR3d2hghS2H0tNZTZrrxtkwhHtmbTRbofUIfF2b0dJOh77nLWEat1AVtXRWSlECqjcRnxcOSP1qIscIM4AzfdKnEVN+AUCa13PVKt2Ew67WpRP9D+v2OK9vs+rPl/x6tqnMDB+VLlvF/PpWBfCOIKfVZaOqq6kf8lFBUvx7k/VIku9RGwQqOuezvLI2MMLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(16576012)(316002)(5660300002)(53546011)(2616005)(83380400001)(31686004)(956004)(2906002)(66574015)(8676002)(186003)(4326008)(6666004)(16526019)(6486002)(26005)(52116002)(66556008)(478600001)(8936002)(66946007)(66476007)(36756003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cFZPVGpYT3BEdzZQaHViNzF3d3pLM0dibUcyb0poYXdibWVKNHhlYXZtSy9a?=
 =?utf-8?B?QXhrSi9yOEg2ZEs0Wkdiak5hUHdvN0dXeFo0YnFNL3EyeDVTbFZwcjBqN3Zz?=
 =?utf-8?B?RmhGYS9WUmJoazlveCtqWkhRanpyZlEyRlkzNTI2bWdxWWZIYTVOcjVEVWtm?=
 =?utf-8?B?VmpTRnNUUmc4Z3ZldWNPU3BQRUZxUG53UXU4OWRIRExIaFJJUnZadCt0MUR0?=
 =?utf-8?B?YTRBWnRpNE5sRmFKVkd6aEJNV3hNSDJUbWltc1owWER5Y2NweUlpbzJNTGRD?=
 =?utf-8?B?WWpFWVVPTVEyY1R5S2h3L2VnVUJiU2E3QVR4T2cwd1dlM0lrUGdwNEtPN1BO?=
 =?utf-8?B?bFgzNjZibTVLTkdrbm9nSEhnclVaUk8vM1FoWnNoaytLUFZnSzN2NjY3RGFC?=
 =?utf-8?B?TzY5NGVtSTR4blRHdzRvNlI1NFFlWk1Lb0FFU2FZQjlFbnJJcERrYzlURzN6?=
 =?utf-8?B?Z1AvZWw4eVJpVG1MUGNUZ1BTdUVUVEJudlR4bXBBSm5RaEJFNXdRQTR6L1Ey?=
 =?utf-8?B?N1I1TW1GWFhKY3pRWDUza2ZDbVFsM09ZL3p4bTJCTXBjZEtwT1V6ZStGT3Yy?=
 =?utf-8?B?ay91Vmk0cE9aNWhpT0NWWW43ekZwcjFCblpwR0Zib0p6d0dIOWlDRlJSRDIz?=
 =?utf-8?B?M2VHWCsvZ3psTEJLQjNTTjVCckp5Wno1NVVoZFRBNWF6T01PamtXbWp6c2tV?=
 =?utf-8?B?M0xFZ29rVVFCNUFFcVI5bTVDYXBVQjk4b2lFdGlyUTBFV0VtQlpwVXRwRENX?=
 =?utf-8?B?Um9lZjJLOXBUNVRPVzYwNEo5QzAvS0JnakxrRXQ2OHQ5TE5EU0pLd1RuZWRB?=
 =?utf-8?B?ZS9pMUN6ZWlmT1pnWlZBRWNTdGJCc0RCRmlOK3lNWHVkUE9QVUtnbFFnSHNE?=
 =?utf-8?B?NU1zQk9BZ05kWGRQS3BnSTZKUWw3aHltZzlLUVJvR3lNOFlpNW9STnM4RkZB?=
 =?utf-8?B?bjhReVBVY3FXS2RSd3g5dFlKcW02NENhQVlnRS9NVHFpRUppQ2t5YXp1RUNF?=
 =?utf-8?B?Sm9uaXlMNUdaWElJS2RJNGpTNDk4R1FKNDdodGJZYlJZRUlzVndDYnpEV3Q4?=
 =?utf-8?B?QW41Q0VkTWIram8vR0NXaGJaRCthWDNiTWZCSXA3ZnY3YytESEljck9xUThG?=
 =?utf-8?B?WXo0TUNjNytFNi9yb1ZBM3p5QnZkdDBxbFBINEdHSHJEaEkzNDBvMzFPM1Bt?=
 =?utf-8?B?K3N2TnlNcFVtQzZZRHV5bTh3alBseWtrOFZLa3ZxQ2pEMlV4RUNMYisvYS9F?=
 =?utf-8?B?REJuSTdzN0lwSDd3R1h5RDNScFlTaGZxYlljMmJIL2h6QW8rNHNaUWl2VEQ4?=
 =?utf-8?B?NVdQZk50MWNGUDZsU1dxeVFFbTR6VlhwdkEzaG1kYlg0dmE4dERKa0x6TEZF?=
 =?utf-8?B?OUV2OWE0SkpDWnhFRHdxcm9EY3NYSmtGVVo0NTUxZGhhVkxrTkNUdXpmV0tE?=
 =?utf-8?B?V2FTalhNTGtnc1JuK1h6M2lLdWJCZzJCaXRhV1ZtR1FsWUx0cmVENVZaS2FZ?=
 =?utf-8?B?czdUOEh5SXZpYkkvSTI1OGVDSW1sdFlrNGh4Y2pqVS9HQ0hzK0pPTlJ1Vlpz?=
 =?utf-8?B?anBweVZkMjIzMndlRXRqNW9tV0FHYXdaNVdlQzgwNnRLeGd2Z0NWUjMrRkpQ?=
 =?utf-8?B?am1kWnpxNmVtVStaSVNMR0duUGlzS1I2YnVuT093QTcrTW5rNUNxcDlHU1RQ?=
 =?utf-8?B?bVFNMjdIb3M5WHFZUHdabTBOS1NPSEtSVzlVVGVBcXR4aXZzRndrTkNUZXlq?=
 =?utf-8?Q?cbiZ3NtAJKI91nn4QeaFlOdanuew6Fvo3tz3JmA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed8b26a-2a2d-492d-ae22-08d8d3f59cdd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 10:11:52.8835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0zTMkXpd8akiwRTc5tM0y3OTTe9cftss+0Dmb1rNIEZUPRXF1CYrf7diVjvYcG3Jjaq0DYV9NkMgcwJ72bVBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Cc: Arunpravin.PaneerSelvam@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGVzdGVkIG9uIFJYIDU4MC4KClRoZSBzZXJpZXMgaXMgVGVzdGVkLWJ5OiBOaXJtb3kgRGFzIDxu
aXJtb3kuZGFzQGFtZC5jb20+CgoKT24gMi8xNy8yMSA4OjAwIFBNLCBDaHJpc3RpYW4gS8O2bmln
IHdyb3RlOgo+IEFsbG93cyB0byB3YWxrIG92ZXIgdGhlIGRybV9tbSBub2RlcyBpbiBhIFRUTSBy
ZXNvdXJjZSBvYmplY3QuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gLS0tCj4gICAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yZXNfY3Vyc29yLmggICAgfCAxMDUgKysrKysrKysrKysrKysrKysrCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTA1IGluc2VydGlvbnMoKykKPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgKPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMTMzNWUwOTg1MTBmCj4gLS0tIC9kZXYvbnVsbAo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgKPiBA
QCAtMCwwICsxLDEwNSBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBP
UiBNSVQKPiArLyoKPiArICogQ29weXJpZ2h0IDIwMjAgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywg
SW5jLgo+ICsgKgo+ICsgKiBQZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNo
YXJnZSwgdG8gYW55IHBlcnNvbiBvYnRhaW5pbmcgYQo+ICsgKiBjb3B5IG9mIHRoaXMgc29mdHdh
cmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1lbnRhdGlvbiBmaWxlcyAodGhlICJTb2Z0d2FyZSIpLAo+
ICsgKiB0byBkZWFsIGluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRp
bmcgd2l0aG91dCBsaW1pdGF0aW9uCj4gKyAqIHRoZSByaWdodHMgdG8gdXNlLCBjb3B5LCBtb2Rp
ZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmlidXRlLCBzdWJsaWNlbnNlLAo+ICsgKiBhbmQvb3Ig
c2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNvbnMgdG8gd2hv
bSB0aGUKPiArICogU29mdHdhcmUgaXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRo
ZSBmb2xsb3dpbmcgY29uZGl0aW9uczoKPiArICoKPiArICogVGhlIGFib3ZlIGNvcHlyaWdodCBu
b3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgaW5jbHVkZWQgaW4KPiAr
ICogYWxsIGNvcGllcyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUuCj4g
KyAqCj4gKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJB
TlRZIE9GIEFOWSBLSU5ELCBFWFBSRVNTIE9SCj4gKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQg
Tk9UIExJTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLAo+ICsgKiBG
SVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklOR0VNRU5ULiAgSU4g
Tk8gRVZFTlQgU0hBTEwKPiArICogVEhFIENPUFlSSUdIVCBIT0xERVIoUykgT1IgQVVUSE9SKFMp
IEJFIExJQUJMRSBGT1IgQU5ZIENMQUlNLCBEQU1BR0VTIE9SCj4gKyAqIE9USEVSIExJQUJJTElU
WSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLAo+
ICsgKiBBUklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRX
QVJFIE9SIFRIRSBVU0UgT1IKPiArICogT1RIRVIgREVBTElOR1MgSU4gVEhFIFNPRlRXQVJFLgo+
ICsgKgo+ICsgKiBBdXRob3JzOiBDaHJpc3RpYW4gS8O2bmlnCj4gKyAqLwo+ICsKPiArI2lmbmRl
ZiBfX0FNREdQVV9SRVNfQ1VSU09SX0hfXwo+ICsjZGVmaW5lIF9fQU1ER1BVX1JFU19DVVJTT1Jf
SF9fCj4gKwo+ICsjaW5jbHVkZSA8ZHJtL2RybV9tbS5oPgo+ICsjaW5jbHVkZSA8ZHJtL3R0bS90
dG1fcmVzb3VyY2UuaD4KPiArCj4gKy8qIHN0YXRlIGJhY2sgZm9yIHdhbGtpbmcgb3ZlciB2cmFt
X21nciBhbmQgZ3R0X21nciBhbGxvY2F0aW9ucyAqLwo+ICtzdHJ1Y3QgYW1kZ3B1X3Jlc19jdXJz
b3Igewo+ICsJdWludDY0X3QJCXN0YXJ0Owo+ICsJdWludDY0X3QJCXNpemU7Cj4gKwl1aW50NjRf
dAkJcmVtYWluaW5nOwo+ICsJc3RydWN0IGRybV9tbV9ub2RlCSpub2RlOwo+ICt9Owo+ICsKPiAr
LyoqCj4gKyAqIGFtZGdwdV9yZXNfZmlyc3QgLSBpbml0aWFsaXplIGEgYW1kZ3B1X3Jlc19jdXJz
b3IKPiArICoKPiArICogQHJlczogVFRNIHJlc291cmNlIG9iamVjdCB0byB3YWxrCj4gKyAqIEBz
dGFydDogU3RhcnQgb2YgdGhlIHJhbmdlCj4gKyAqIEBzaXplOiBTaXplIG9mIHRoZSByYW5nZQo+
ICsgKiBAY3VyOiBjdXJzb3Igb2JqZWN0IHRvIGluaXRpYWxpemUKPiArICoKPiArICogU3RhcnQg
d2Fsa2luZyBvdmVyIHRoZSByYW5nZSBvZiBhbGxvY2F0aW9ucyBiZXR3ZWVuIEBzdGFydCBhbmQg
QHNpemUuCj4gKyAqLwo+ICtzdGF0aWMgaW5saW5lIHZvaWQgYW1kZ3B1X3Jlc19maXJzdChzdHJ1
Y3QgdHRtX3Jlc291cmNlICpyZXMsCj4gKwkJCQkgICAgdWludDY0X3Qgc3RhcnQsIHVpbnQ2NF90
IHNpemUsCj4gKwkJCQkgICAgc3RydWN0IGFtZGdwdV9yZXNfY3Vyc29yICpjdXIpCj4gK3sKPiAr
CXN0cnVjdCBkcm1fbW1fbm9kZSAqbm9kZTsKPiArCj4gKwlpZiAoIXJlcyB8fCAhcmVzLT5tbV9u
b2RlKSB7Cj4gKwkJY3VyLT5zdGFydCA9IHN0YXJ0Owo+ICsJCWN1ci0+c2l6ZSA9IHNpemU7Cj4g
KwkJY3VyLT5yZW1haW5pbmcgPSBzaXplOwo+ICsJCWN1ci0+bm9kZSA9IE5VTEw7Cj4gKwkJcmV0
dXJuOwo+ICsJfQo+ICsKPiArCUJVR19PTihzdGFydCArIHNpemUgPiByZXMtPm51bV9wYWdlcyA8
PCBQQUdFX1NISUZUKTsKPiArCj4gKwlub2RlID0gcmVzLT5tbV9ub2RlOwo+ICsJd2hpbGUgKHN0
YXJ0ID4gbm9kZS0+c2l6ZSA8PCBQQUdFX1NISUZUKQo+ICsJCXN0YXJ0IC09IG5vZGUrKy0+c2l6
ZSA8PCBQQUdFX1NISUZUOwo+ICsKPiArCWN1ci0+c3RhcnQgPSAobm9kZS0+c3RhcnQgPDwgUEFH
RV9TSElGVCkgKyBzdGFydDsKPiArCWN1ci0+c2l6ZSA9IChub2RlLT5zaXplIDw8IFBBR0VfU0hJ
RlQpIC0gc3RhcnQ7Cj4gKwljdXItPnJlbWFpbmluZyA9IHNpemU7Cj4gKwljdXItPm5vZGUgPSBu
b2RlOwo+ICt9Cj4gKwo+ICsvKioKPiArICogYW1kZ3B1X3Jlc19uZXh0IC0gYWR2YW5jZSB0aGUg
Y3Vyc29yCj4gKyAqCj4gKyAqIEBjdXI6IHRoZSBjdXJzb3IgdG8gYWR2YW5jZQo+ICsgKiBAc2l6
ZTogbnVtYmVyIG9mIGJ5dGVzIHRvIG1vdmUgZm9yd2FyZAo+ICsgKgo+ICsgKiBNb3ZlIHRoZSBj
dXJzb3IgQHNpemUgYnl0ZXMgZm9yd3JhZCwgd2Fsa2luZyB0byB0aGUgbmV4dCBub2RlIGlmIG5l
Y2Vzc2FyeS4KPiArICovCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfcmVzX25leHQoc3Ry
dWN0IGFtZGdwdV9yZXNfY3Vyc29yICpjdXIsIHVpbnQ2NF90IHNpemUpCj4gK3sKPiArCXN0cnVj
dCBkcm1fbW1fbm9kZSAqbm9kZSA9IGN1ci0+bm9kZTsKPiArCj4gKwlCVUdfT04oc2l6ZSA+IGN1
ci0+cmVtYWluaW5nKTsKPiArCj4gKwljdXItPnJlbWFpbmluZyAtPSBzaXplOwo+ICsJaWYgKCFj
dXItPnJlbWFpbmluZykKPiArCQlyZXR1cm47Cj4gKwo+ICsJY3VyLT5zaXplIC09IHNpemU7Cj4g
KwlpZiAoY3VyLT5zaXplKSB7Cj4gKwkJY3VyLT5zdGFydCArPSBzaXplOwo+ICsJCXJldHVybjsK
PiArCX0KPiArCj4gKwljdXItPm5vZGUgPSArK25vZGU7Cj4gKwljdXItPnN0YXJ0ID0gbm9kZS0+
c3RhcnQgPDwgUEFHRV9TSElGVDsKPiArCWN1ci0+c2l6ZSA9IG1pbihub2RlLT5zaXplIDw8IFBB
R0VfU0hJRlQsIGN1ci0+cmVtYWluaW5nKTsKPiArfQo+ICsKPiArI2VuZGlmCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
