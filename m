Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DDAC07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0B56117A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0B56117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105A16E7D1;
	Thu, 15 Jul 2021 09:29:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D03C6E7D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 09:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEw/UZnema8cMjbgGntCvGGIS1JMv4mJwJH40gj+4qi323YLEtprfrGpVyUrJAigOve4U55texuePZoSUIJK4gkfM0xHv0+AeGbRqf4xff1Nkegadjirii2C8h0H2jMHIvn0/JQoWj6dC2q4koGUnKunU3E6sLPNBnabWXZpyKyC6YvCniySYbGW/R7VTmHoY+8sfyctCL9jdN2nq+suVFxlVtIOqY15UZM6Cq/aOijx6z2hUPWmHPOTvK5hhyXtXceaerrhzAjITKf8tHRh5m39ibs9L8xT3eu5AlicmDGZgcj9GuHXMx/yb9uRRlE3H9gdryjAGjNbTz96IB13Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySKGmwLwRYSwAHqdshUywBA6qJrwAXXkJsVAXju4JdI=;
 b=BfMHauTlVGVdlyrGpSaPr1Gpx3XKNSWTf+wQbiWx8f36ocHe82HJ+EefuGzT3arqo77yyAweDikTWa5GeBTn9eDqoQSTRsXdTduFiq3LzngxUYm8/+vKASEVUJgMz4wbL9GaJbY+P6Rzy+IUdMmVtaBq4whMNTsQx8ggsGgxdXE/b/J+dnJHLZq0HC+gbJcaBt5/fhXqP6L8ixNDa9P86Pw8lKLhCYznYE8QmjoVkem2+Kp3eTDE/uHOAvUNP+d1vWUQdGNStYPJk8Dg6IYmXMYCJAztVh/D5yENctD2VlsTgV+6bAqq7V1IRDd1VgtMe1az8Y3SLXDbKCp0E2lBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySKGmwLwRYSwAHqdshUywBA6qJrwAXXkJsVAXju4JdI=;
 b=AWs0Afr1i/6ldy+OCCB8Av0Svh84xYiHNuJ1/TJZf7gahm3RaxEt+3JwdcBxBcngJutwhJVe4Bmm6h/M5Fgr+V9iYIGc8N0W6J2BvQLO1ceKfmR6fxi2D7dweBEzilnSb4PuSHAWTD/p/vN4CMR0Gn8TWCpHADuFrJ+d+kLHK+E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 09:29:50 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 09:29:50 +0000
Subject: Re: [RFC PATCH 2/3] drm/amdgpu/ttm: replace duplicate code with
 exiting function
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210715082439.678512-1-kevin1.wang@amd.com>
 <20210715082439.678512-2-kevin1.wang@amd.com>
 <0606dabf-3558-d263-fa88-e6d6fff47047@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <12b0918e-f37d-d283-0a89-eb4a36158d7f@amd.com>
Date: Thu, 15 Jul 2021 14:59:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <0606dabf-3558-d263-fa88-e6d6fff47047@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 09:29:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d687fc-c8f2-46e8-7592-08d9477317f8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB510958C9C4F3E94DDC1A429E97129@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3EdHG0ekQnCVlqGROYLUvcmxZtDreeDfaboJcjl2IPq6Vvzi81TVMT6a9mTJZgQqCYxmooDAPmWKaZ1hIVudY2fJm5gJarb+YJwtXHw2VRvbTXyzjU25V/SSsx4/X44A4xmb3ovdiyJSY7sfFtJaxhOj0Z8aBBxvgbFVofjZlq7IuNN6K2PaDq+aI8Cam6IHMgqV4F0SX6LiQpSu08fOczgOQ4HkOYn9sYZuqolTwUv5tfXZNURIBtRfMh44BUfMDumOk/3SrAnD/6ftXnVZkmxUdfI0no+bWi9krqKNoUqzDEBfRBaOd0H6RJSmmzbYo6YxKN/PL3sXPUwW2dlF4gw5Dx0VxEMGJWnlF8EHB6R2YedFuTjrph2GTqTwnCr2Klgwt5A/vCHc+cbFBpVo51+lqWt0VAufcTTxK9qiO0O3Ibm6p+YdiYPMVYhGy3prgdxw/5h+FKDBKJlogjegRP3lnAxCLDiKcarJbKZdUniWuJFykZt5SmjMHe5Xt6TSiiE1U/jgS/Wg/OGtv7EH2dqU+hcNLnqIfOWvXoplY1WTW0GcDZ34byvuEM4io8iczSnSbJWeBSbYsDnTdfrWwI6KljMEKoDeFzFGm2JBlmCYFKiIOLWo0vehvm1NdWbpgnJ2e+srAIpGkHhvaWKH6fSNM5XsCm1ft+j53Hhk/EsB0LqMRQn6h9bXZRj2rBrlRaUmTz5JpASt92KLbAeA2rlqyUZUV3Fj1JF1rEMcs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(956004)(4326008)(31686004)(38100700002)(2616005)(66574015)(8676002)(478600001)(6486002)(8936002)(86362001)(36756003)(53546011)(66556008)(186003)(6666004)(26005)(316002)(110136005)(16576012)(5660300002)(31696002)(83380400001)(2906002)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHB1SnNXZEhNUGdrRVVqM0lUbU04NStxSXMxclN0UkRaWjlCZ2FpRC8vbnNU?=
 =?utf-8?B?K2lWYnRLVkZZUkZ1OGF1OGlFMXpqdzlUTnI2elVJb2VaN0xkN01VclFhM3p5?=
 =?utf-8?B?NXlwYkpZYTBZWDNta0NMZ2xzQ0Vadm1mZFhUVVJSYXNqNi95QkhoUlVvOEQz?=
 =?utf-8?B?bHNiUVA0SkRWNTl6L0RZZUcyY1UzdXZ1QjYwamxIUUFZS09CUDZMSXFvZnRs?=
 =?utf-8?B?WW03UnlQTDRXQ2ZUTmRiVEdiVk9LRGgwMEdraFBJOTdRcXV0cXVPekNaNGlm?=
 =?utf-8?B?Z2w2UXVXUTlmaXgrQ1Ewc1pIVmZVODJCSWJ2aGR2eHdVYjIrbjFrWHF0Q3cx?=
 =?utf-8?B?eFJxbXhqUnlmQmZqK2VhWDlrYVM5aDA5TGNVNXBWNGNaWGNvcktuTjlOSmVp?=
 =?utf-8?B?dnBsUUl0eFZ0YTdvUmF4SDVacjVzZEtmZk8zbkZwU2Y0NG1wZHFzSG5Ncjla?=
 =?utf-8?B?R0lPY2daSEJFZ2pRbkttMkpFOWx4ZGRuZlJHTG94dlQxcEthM0pMSXEvcVBi?=
 =?utf-8?B?cGFKOGFsdU95Q1p5UGQvSkc1ZWVMOXpQTElsSWlsNUQ2eHJtTWhVWHV4bHNq?=
 =?utf-8?B?M2dMcnZBWmt0NkF6VHVWWitJeVpzSlFuNUErUUVnMEFtYno4MGVFWm42SCtR?=
 =?utf-8?B?SUdpRXgvblM4S1VhQmM0TExKMGFVRzZpeWladkhoU0QxZ1VZdzRHaW5LdXJm?=
 =?utf-8?B?Q1MrRFFNZytrQ3Q5ZHZMNlgxZmFBNkxPTG1WajBjaXBiSGt1VFhlZElDZHE3?=
 =?utf-8?B?L3ZBQlJDODRSYVQ1Z2ZUYkxOTzNtc0kzMFVqLzBBMGExbnBDR2lialZlc0NX?=
 =?utf-8?B?RVo2YmhURzh2NkZMZHZGVUVFYkxnZEw0RGYyM29RMGJ6ODgySWYrRXk5eklS?=
 =?utf-8?B?ejlGS3VrdUhPbWdmODRZSTB1czZFYXR5Zk5mQ3d6bVRwVE03ejVhUjhlWGVG?=
 =?utf-8?B?RmNDcm9SNHMzSHZEK09PREVXa3JBcEg0Z25rUEVZcklvcFo3WWd4eVZaSkNm?=
 =?utf-8?B?djV0Z3YzTDV3ZXlnY2pieldzVFBrZnhvRExYT1psWFhWanlFR3VvTmdQeGpt?=
 =?utf-8?B?RVVZSkwwcndrRFFBYk9oamI5UU9jNnNPcEJrRmd1MDcremZ2L3o1SlkxNDIy?=
 =?utf-8?B?Ync1T0YrUlJoSHZTcDBxdFhzNVJpSHkwRFg1cm5OT3NiREhwVmM4NVA5TTVy?=
 =?utf-8?B?aFZveXdhZHdQais3N2VvMjFoSGRwV2F3RTlVKzZPRm1XdnRPRkRBTm5SdnM5?=
 =?utf-8?B?THVURUdtb2NzeWNkWmZ4RXhCeVl6M0oxWFJqTHZtNGkvWFRTTEpPTldyQ1Qz?=
 =?utf-8?B?OWxySUxPMXUvdkpueUkzQm5XcC9aV3hBQnZkYUpvTTZiSXpMb210akVnNnhQ?=
 =?utf-8?B?eGJhNk9tSkc1TVBCYXFjZXBSNktoa3pTek4zS3l1NFBQbmh1aWtGVkNweFNn?=
 =?utf-8?B?SHl1VU9Yd3RCZ3V6a2RGRzhReVJHTkg1VUxUNnZLN25IbjVXUjJVdnlqVlR1?=
 =?utf-8?B?Uno3V1VRTUtlWmRHU1dhUDFobmd5ZlpKZDQ0Vlh6UitMcHlodTJNcjBhaHE0?=
 =?utf-8?B?aGR2SjgrME53Z0NzenpiYnoybkJYczVxUFJINWNiYUk3ZmhPSWtrWjFoQXAy?=
 =?utf-8?B?MnNYRC9ObU5CcklpMjZZOVZscGliamIrdDRMWnlkTmVuTmtZelhjQUdVVUo5?=
 =?utf-8?B?dHllZnpJU0V1RXYvRUJNNmVralpZVit5NUZBS0MwT3BFL2Z4WGhaODhCeENN?=
 =?utf-8?Q?N6hdxYum0bHJYTy4jYuxZVP+LoLtkQbv14mXNOK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d687fc-c8f2-46e8-7592-08d9477317f8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 09:29:50.0089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH1vRLhjp1HuYNK2YR/dJCRMZfqd1OyYO5YA0jBUQjZojRNKn+SGJVgb9uiylmtJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
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
Cc: alexander.deucher@amd.com, frank.min@amd.com, hawking.zhang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiA3LzE1LzIwMjEgMjo1NiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxNS4w
Ny4yMSB1bSAxMDoyNCBzY2hyaWViIEtldmluIFdhbmc6Cj4+IHVzaW5nIGV4aXRpbmcgZnVuY3Rp
b24gdG8gcmVwbGFjZSBkdXBsaWNhdGUgY29kZSBibG9ja3MgaW4KPj4gYW1kZ3B1X3R0bV92cmFt
X3dyaXRlKCkuCj4gCj4gTkFLLCB0aGlzIHNob3VsZCBpbnRlbnRpb25hbGx5IG9ubHkgdXNlIHRo
ZSBNTSBwYXRoIGFuZCBub3QgdGhlIGFwZXIgcGF0aC4KPiAKCldoYXQgYWJvdXQgcGxhdGZvcm0g
Y29uZmlncyB3aGljaCBkb24ndCBzdXBwb3J0IEhEUD8KClRoYW5rcywKTGlqbwoKPiBCdXQgeW91
IGNvdWxkIHVzZSBhbWRncHVfZGV2aWNlX21tX2FjY2VzcygpIGhlcmUgbm93Lgo+IAo+IENocmlz
dGlhbi4KPiAKPj4KPj4gU2lnbmVkLW9mZi1ieTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1k
LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
YyB8IDcgKy0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDYgZGVs
ZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5j
Cj4+IGluZGV4IDJhYTJlYjVkZTM3YS4uMmM5OGU0MzQ1YWQzIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+IEBAIC0yMjA3LDcgKzIyMDcsNiBAQCBzdGF0
aWMgc3NpemVfdCBhbWRncHVfdHRtX3ZyYW1fd3JpdGUoc3RydWN0IGZpbGUgCj4+ICpmLCBjb25z
dCBjaGFyIF9fdXNlciAqYnVmLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTlhJTzsK
Pj4gwqDCoMKgwqDCoCB3aGlsZSAoc2l6ZSkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQg
bG9uZyBmbGFnczsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHZhbHVlOwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKCpwb3MgPj0gYWRldi0+Z21jLm1jX3ZyYW1fc2l6ZSkKPj4gQEAg
LTIyMTcsMTEgKzIyMTYsNyBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfdHRtX3ZyYW1fd3JpdGUo
c3RydWN0IAo+PiBmaWxlICpmLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHIpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByOwo+
PiAtwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPm1taW9faWR4X2xvY2ss
IGZsYWdzKTsKPj4gLcKgwqDCoMKgwqDCoMKgIFdSRUczMl9OT19LSVEobW1NTV9JTkRFWCwgKCh1
aW50MzJfdCkqcG9zKSB8IDB4ODAwMDAwMDApOwo+PiAtwqDCoMKgwqDCoMKgwqAgV1JFRzMyX05P
X0tJUShtbU1NX0lOREVYX0hJLCAqcG9zID4+IDMxKTsKPj4gLcKgwqDCoMKgwqDCoMKgIFdSRUcz
Ml9OT19LSVEobW1NTV9EQVRBLCB2YWx1ZSk7Cj4+IC3CoMKgwqDCoMKgwqDCoCBzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZhZGV2LT5tbWlvX2lkeF9sb2NrLCBmbGFncyk7Cj4+ICvCoMKgwqDCoMKg
wqDCoCBhbWRncHVfZGV2aWNlX3ZyYW1fYWNjZXNzKGFkZXYsICpwb3MsICZ2YWx1ZSwgNCwgdHJ1
ZSk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXN1bHQgKz0gNDsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGJ1ZiArPSA0Owo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
