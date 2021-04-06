Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0194AC433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 15:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C8F613A0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 15:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C8F613A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110486E1D2;
	Tue,  6 Apr 2021 15:35:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227976E1D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 15:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGmjuluh/SW3HkWIHXmkjPnmsewbYw+i6pIXJRm1iKvM2ugEpGawvxf82te8DnxspZr2+8myp2x32kzA+oYxyC9bTJbQkU1b3nfcYWmkR0eB/oryZLZiOmCDy420n+PuH3kkFYWwygrC6ombdqd9U/FrOD66hA92+avLo9c3ytFWDwyUPHWY//+KHjRL397GatMTnn1G196DWN+igOj67ZI5Bc852vW6hiRlFsMzCQcD12txCfox6zH6sqJOrh2RLgpLsL6uV4N1q2y3vXZyK+sKsWXbIQGdfyxpU0piVhildfqKfTTeHTN56y8pNM65KAJmu6BGUYYMy6E7HGa/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAnpqdZ/n6vps+OrrHcACQCVVWdxS3vi6Qm0vgl4ajU=;
 b=daIAWE9X4CsaDh5224w36WgRIBjaOEvrwWQfzpV031H/YLLFXju4DfplOoqG6sXOml5sUEUOUP38nl3jhqvcoNfVp0wvga2h2+0pZStpxcDuOtQynf2GsGfyWuqDzNBVCDJ0D/N3U/SgnJ57h4BOKEphPilv2ujopxl+fJBKKjELRCZs9lko90xdIw6Ftj2iVx6drzVnI0BGycByR/R0funST9i7AWsQHUbsd0+4Rhc5LgQQeyzYZa5zmQqwHuZGWsCkr5xyOWN8vCPVBaIlJL+G5K5Ik62gr5OUlYkTjoOnfLgrtVMfu+PCl5rvFPa5mmfqgiGldwMY4vxBMjv9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAnpqdZ/n6vps+OrrHcACQCVVWdxS3vi6Qm0vgl4ajU=;
 b=LbhXYnOJFmZkhRfJzIHsKuE9FHb72TRkq8HmQRQO6tTdCapM/VsCXxcglAcIhn1/62KvC2oDpuntidPiOQjGrJi+cVsOVASMPciLRaebpBCcBamzcGcGay8q56ysSKj08/VYxB29098oUra8wmB6P6a4wyJ/AA53Gv0Bm9/NlRI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 15:35:42 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.039; Tue, 6 Apr 2021
 15:35:42 +0000
Subject: Re: [amdgpu] Compute kernels still run when the host process exit?
To: Alex Deucher <alexdeucher@gmail.com>, Smith John <ls.cat.kth@gmail.com>
References: <CAGztBWXhxjoOAQ2AbiR0KGEV3g0dSxYaWwUGnOg8w70vCW1VuQ@mail.gmail.com>
 <CADnq5_NF6=_cDEW8gxrbEd38EAxfh0y9je9+F7fXKV1Eojdqqg@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <af27e67f-24c7-3bc9-ef2f-12aeecbe11b2@amd.com>
Date: Tue, 6 Apr 2021 11:35:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CADnq5_NF6=_cDEW8gxrbEd38EAxfh0y9je9+F7fXKV1Eojdqqg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [142.116.84.209]
X-ClientProxiedBy: YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::46) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.84.209) by
 YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32 via Frontend
 Transport; Tue, 6 Apr 2021 15:35:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b61929f-2023-4d8c-64b7-08d8f911a2f4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3934:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39343602A6E649499D4FCEC792769@MN2PR12MB3934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeYw2Ytd7ZsOr0b9Co7rzoeeGoDLynnONS9tLMGicn70JkjVR37XOviaPAlKubXLEewijbP+PtIXh/xYZrbgJTam8XwBOH+hYe35/XKRDq9mic8OKHlCIFmzCGq0zjOXoCa0PhF0o9Yw+6RwcSnTl6Shmsh3iBY47tj5fv1M6h55hyccsZWA+tJuCts+jDGR9mnH5c8qQ5AiSWdDzN8X2iQ/ZvjMZMahg/IG6pLZk/y83bYd3Z/68bzYO12pG+awm2//xATBMhVz/ifEqv9ES28PhwZpy3JkfgMyxgvNE93hQBwCCmy9855bRv0IbHUkcU2XKCit5TNw0CYJIuAv0FYEngfnnvHa+fcTxNyt66lNnPJ4pZd03knGWlekf9EUq+oCM67VOwS75XzX6QIPG7bF5r5mTNr68dwyOYtS7nIsM58kST9+TeTbvVS68gexfA6og/NioKAFW2nTLhUy6W6ZaRUtRrWW66pmjEb/uRGKDLoESPSIk5xg/nHGnM0ZViyQ3rfp6PtAzoHYSlBB8j6uUlTBpAjZJIZbVfHLOvn5KFR66isgEdVezl7GFQlm2qGpP/a6G31T7r7D3Kjg1Px98hPEYYRAyc6ZQCTH+yWR/EamUOVJ1JP2ouMxivMUEYeYGB9fn7rCGNH5RjUaKPMwM5CJB9GEfwgp9vGPJ4PJICqzqVot70h3lrVE7Fexce9Nb2R8GuOr8I8YCHCYeTLjKDVIODTwKFkF1FzCDHbu1aBX/jCNJlGdD2pOhj0W3VLlntTFBXsM8psvIWrPfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(36756003)(5660300002)(66476007)(956004)(4744005)(2616005)(53546011)(110136005)(44832011)(31696002)(316002)(66556008)(86362001)(6486002)(16576012)(16526019)(478600001)(186003)(26005)(8936002)(4326008)(66946007)(966005)(2906002)(8676002)(31686004)(38100700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S1B2UVNLZHZTaDZuZ2E2N0FpQmgzU0ZSYUI4cXlnNERIRE1xTmtYQ1VHMXJv?=
 =?utf-8?B?NmxHc2d0NDBDeVNNTk9PeDZBaDFlQlR0V1E3MlZOVGd5cmxjRnBFTnVkcm5I?=
 =?utf-8?B?SC8rKzBWcGREUkVibWJaSkJINVJmYmVIaEM1dXNmcEJPUGp6dG1SYW9yTjE3?=
 =?utf-8?B?R1QrOW1oSXBIaXNXcTJhaE5TaENrY3VwYmQ4VmhCUC9mV3lLZVByQVp5SzNa?=
 =?utf-8?B?ZHlhNGd1bzFhclM2eEdKczBnVE5KZTlkQU5CTjQ3bmFMdksrQ3N2MnpHUVhM?=
 =?utf-8?B?UzJockYzUWxFTmFsYWpPZ0pINzRyQWp0L2NxdW1oQUJZSFBJTXo3SklhWmhx?=
 =?utf-8?B?YlpoR29sdk82U0pza2hHQzBPOWl3U0FaeUx1SmsrQnhjbFBnVGhqdUFXM2RV?=
 =?utf-8?B?Qms4bWdMRDJrRHF2RzM4V1AyZ1BxV0lVRGkzUCtSV0Nrc1FVVk5mbnZqSEZL?=
 =?utf-8?B?eXZnTjZGTVoxMDdrUVc1SHJiaVRnaGF4ZmdEanZ3MEpmNCtPKzVMTzQyVVF0?=
 =?utf-8?B?UldRZlMrYkZ3dURoVnBYZjgreFpYT2RVdWdibFFBYXFTVG11MTBOTGRrRXNv?=
 =?utf-8?B?d2ZDVEd4R0VJa1kveG9XMjErdGg0WWNJRnYzOU1kcEg3alg0aXFUY1BReG5i?=
 =?utf-8?B?RzZSZVY3eE8zUElhTzZvREo5U1oxaEUzMHJ5ODRGSGVHOUp6Wmt4K1RYMDkx?=
 =?utf-8?B?T3p2bThITGRjbGpob3V0enYzRFl5TG1yQzhkR2ZwOVU5SkI1TjgxckZMWC9l?=
 =?utf-8?B?V0ZkK0N3V0R0RGJxOVk2Sk5uWHpJaUxxbVp4dS9JQ2FsOUZxUHZxU0lTYzdT?=
 =?utf-8?B?ZEJhZUFGLzV1M3lib2lqUjRLcUswQWVRdmtlNkQ5MWNUMi82UGlwUG5tbGVX?=
 =?utf-8?B?L3pqa2hDTHFCc01vTnNvOVNWbEVKYUJ3ck9SQjJJbkZtZng2S2FwM3ZIRFJZ?=
 =?utf-8?B?SWxienVyWVpXSEJxaDdSU0crRXRoSUdsUXFrakYrNzRoU3pqc21Gb3BZQXJZ?=
 =?utf-8?B?RkI3R3ZFenN0a3dScWpVOHBUV3FUTTdoUWl2Y1hwTE1weEQ3YmxETjVOQnVs?=
 =?utf-8?B?dnhxNVJDblFzaGc3MXltS3VSTUx2REdLSkI5SEx1bU4zdGQ1TEkyY3ZZZDc2?=
 =?utf-8?B?bmF5NEZMdkd2RjR3SXVXRWszRzJhclRCNWhlNk5XUjBvRWhFdVFqWStsdkwy?=
 =?utf-8?B?cDdiTHBCNGZ1YjNDazFQdEZHNnFvZ2hmdjlUdGhRMmJOSUlaYmRBYUpBOTd2?=
 =?utf-8?B?RXU5UUJiWVF2dmxua2FFenF0Y2J2R253cms1ZDY4UDJhaFl4clBmMHEyc0Jv?=
 =?utf-8?B?ZGhJZTlSZWF1VC9WNEdWOG9obDRlTlJmbFk0SmVmS1ZsZTVERkNrblMxWmo4?=
 =?utf-8?B?Q3k5b3l0ZlFqNVhHZUttelVmVk5uVE5CcHRDQ2N0Qis3LzFJWmppUFJ0Z2Nj?=
 =?utf-8?B?dVBDYmlvNFVPZnJSQnJqNUh1UmozVDI1V1FzZFg4elF4aThQQ1ozN0pKVlFK?=
 =?utf-8?B?VGJzd1JLaldmdy9OTy9ybjRBMkkyK1BiNWRFMDZOVWpBZXY2MW1pN1plcm11?=
 =?utf-8?B?UklDT3huZ0JtSTJpUzRHSkJyUlljN3JtSFZyM004cUdLRkNuOTNURGdHYUZu?=
 =?utf-8?B?YUZOWVNka0wyRVNHU1R5N1lXRkZaYmw3U3hBcUY4M0h1cmVobjJVTWMxbmps?=
 =?utf-8?B?YXBIZzNVK0VlckxMZVVMYUVrbE1MemVJK2RNU244OFVjaGI2NktjMUgxYmlJ?=
 =?utf-8?Q?5TpAzJTzJFdgD4l9PF1VJyNcn+sl726wAjDKSRm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b61929f-2023-4d8c-64b7-08d8f911a2f4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:35:41.8701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iy/D7fu2yJbhvtIMHRdjJhoYFuw9Z5nAwMRvmPVlCKOQfNGiR6BApVjZcGlH/pw4m2Uau7m84ffGX5A2Vy12Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNC0wMSB1bSAyOjIyIHAubS4gc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gVGh1
LCBBcHIgMSwgMjAyMSBhdCAxMDowOCBBTSBTbWl0aCBKb2huIDxscy5jYXQua3RoQGdtYWlsLmNv
bT4gd3JvdGU6Cj4+IEhpLCB3aGVuIEkga2lsbGVkIGFuIE9wZW5DTCBob3N0IHByb2Nlc3MsIHRo
ZSBrZXJuZWxzIGl0IGxhdW5jaGVkIHdlcmUgbm90IHRlcm1pbmF0ZWQsIGFuZCBzdGlsbCBydW4u
Cj4+Cj4+IE15IE9wZW5DTCBydW50aW1lIGlzIEFNREdQVS1QUk8gMjAuMjAuIE9TIFVidW50dSAx
OC4wNC41IHdpdGggIExpbnV4IEtlcm5lbCA1LjQuNTMKPj4KPj4gSSB3YXMgd29uZGVyaW5nIGlm
IGl0IHdhcyBhIGJ1ZyBvciB0aGUgZHJpdmVyIGRpZCBub3QgaW1wbGVtZW50IHRoaXMgIndhdGNo
ZG9nIiBtZWNoYW5pc20uCj4gSW4gZ2VuZXJhbCwgb25jZSB5b3UgaXNzdWUgd29yayBvbiB0aGUg
R1BVIGl0IGhhcyB0byBydW4gdG8KPiBjb21wbGV0aW9uLiAgSXQgaXMgbm90IHN0b3BwZWQgaWYg
dGhlIGFwcGxpY2F0aW9uIHRoYXQgaXNzdWVkIGl0IGdvZXMKPiBhd2F5LgoKSWYgdGhpcyBpcyB1
c2luZyBLRkQsIHdlIGRlc3Ryb3kgdXNlciBtb2RlIHF1ZXVlcyBhbmQgZnJlZSBhbGwgdGhlCnBy
b2Nlc3MnIG1lbW9yeSBhdCBwcm9jZXNzIHRlcm1pbmF0aW9uLiBCZWNhdXNlIHdlIHN1cHBvcnQg
Q1dTUiwgd2UgY2FuCmludGVycnVwdCBydW5uaW5nIHNoYWRlcnMuIElzIHRoaXMgdXNpbmcgdGhl
IGxlZ2FjeSBPcGVuQ0w/CgpSZWdhcmRzLArCoCBGZWxpeAoKCj4KPiBBbGV4Cj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
