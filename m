Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655EBC07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 13:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B8A6128B
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 13:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B8A6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C936E28A;
	Wed, 14 Jul 2021 13:09:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A31A6E270;
 Wed, 14 Jul 2021 13:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrVOscqfL2buhPN4p23DmOAaAu4HWNluE4Pp+LpK3Oa1UaHcBIgKrMGWqYccOZNRDnZUK+CDB0Rs4Rl4RYXWnBev5TUepAdT8u2XMscILweay9RzDb3xLhi9hpqhz4q+BREVYEFNNVveqLJgbCWfP9IpDq+eSvRe7p75bKZcY4EtjDpKTe32Y32LQMZYo1pt1pZJP+dsAtQZKCA6JDQePvO6Es72VjRxQGmskllpNzj+OQDxKMJraiIdSJ5fNmeBu363NrSnbXYSMv5qA+31ntlaa9kWEs8u5mCKmEe3OxhbSrtTAXBGhiva2a4JPyRXvm8uDf4x2e9DTpf2V317nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuCUGhi4NoyTnRJHNlMfHabIbfVXxYeGKp+VFlZMeCQ=;
 b=KH1tW9kWQWYCvZRzgFiN1X2HBmDPN5mBci8fmeMBsyHNTTZ0EfJSdGCYa4ALJb7pmFOzTZqYRAZi947zDrFWvRtqTnn0dvyKl94wFQPylnld/nen6/GoDm2MeU7SgHBmydfhPnUwOfqL/dI3fIFVROEo4eCmxuLnY/+mD4FV5tlwW3B8Sium+x8CZ3YOKKplCLe/Clziqs5wHbzV6jVsKSFAGAcwDbptQIAsld7JrrFRPpOKh72rc0oIh4MocQHZr2xICqB7EIJP+Z7fPhactJPRGo7v2qKxtMy6auVK9oJGtrONfIeMafr8vdb4wLWYcMXVU4G8xMpf9gwhEJGJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuCUGhi4NoyTnRJHNlMfHabIbfVXxYeGKp+VFlZMeCQ=;
 b=RxL0YDRGEuOlnWLLza87vYwcmEb5NZBwkacFuHtUzehxicRQxt8t4ynkkfUHrMu4Bq7ObVVdQ/M5iac7nIWnGRoQ+rNWsNjgKjZENaSv62ZDZ/r85/nnCHD5wCSdqJiGUplsK9jlSN6tc9nAku4ojBWqFk7/65oNngcE9UrbESM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2386.namprd12.prod.outlook.com (2603:10b6:207:47::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Wed, 14 Jul
 2021 13:09:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 13:09:44 +0000
Subject: Re: [PATCH v3 1/1] drm/ttm: Fix COW check
To: Daniel Vetter <daniel@ffwll.ch>
References: <20210712220636.475675-1-Felix.Kuehling@amd.com>
 <YO6/8DWgD9d6tJcr@phenom.ffwll.local>
 <acc33c53-b56a-0da4-5706-414a444c6459@amd.com>
 <YO7HNStidzhlHYe0@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c70ca813-72a6-ed20-8fa0-94a55cdbfcbf@amd.com>
Date: Wed, 14 Jul 2021 15:09:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YO7HNStidzhlHYe0@phenom.ffwll.local>
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fe2b:fec6:eeb5:c7dc]
 (2a02:908:1252:fb60:fe2b:fec6:eeb5:c7dc) by
 AM0PR07CA0015.eurprd07.prod.outlook.com (2603:10a6:208:ac::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.8 via Frontend Transport; Wed, 14 Jul 2021 13:09:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae48006-155a-4a75-1355-08d946c8a5fa
X-MS-TrafficTypeDiagnostic: BL0PR12MB2386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2386A3C9D623AE9E07D2992583139@BL0PR12MB2386.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvyxCeB0LBVXhoGZV2rTsAb9FELEOTa2g+WyimjALO2URW3Ep3U/sKeH++pOyg/etIofkqpC4OOiyjZ7XyGO3qhyrsKFe5wt7mW4c14zNrLsQNzfjGZsMWC6nPYDowTl6mC/kK8n/VWUyv8VjTLd6sBBDCrjhsrVsTpXOqtAJ9NOInGhqdKsL19AZuHwShq7yG987xDqcyoJ/JmpCSaxF29nZmQgB06PQIiCbAN/QO14h4LO4hiZoqXlIfsL4O0Csjx/VmMNRLJ05ZrIEOumeT9BVRH3DsAewGE8h6fHXOe5pq+kVHSDaz+KEkn/ntzDt5KWBsFNvoKGbq2bACZ5By7WkhZMyn4CWDU2L8IxRjf/U9TFc1h83Dxp7+G36/fFNyRwUH3NjDMV/KUYsZzlyx4WdDha6I0Croxx595BcGXAxUi9rn6ue0FHRlA4gzJXOPc8swuIRV6gOmza25mdlkkK75szje4xVT5p2J6S08sDiaiTRR5TfrI5Tto6ML6M3H2vtsq35u9RhJAeEh8RkmsxeJ89Hwai/lOwKzu4P512E1wiULT/C048hQf0x0RWRLTccquo8kNjVhS/ub/Mii8Ggl0n76Ue5ogaBDInznQ33W/LH2BCub/eyQ67nXL6cJ5lAsPZZidSifnK+5fTOX96t/99iPrXvr4G0q0UvDBRRkBVceM9qlkNrgX5TXOoFdtstu3BUbQTQhiYG0uHny1X4EkAVqQqTcETzlBr7B4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(66574015)(6666004)(83380400001)(8936002)(2616005)(4326008)(2906002)(5660300002)(86362001)(186003)(6486002)(8676002)(31686004)(38100700002)(66946007)(54906003)(66556008)(478600001)(36756003)(6916009)(66476007)(31696002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnM5bHgyeHRoNTRGdlIwdFUxWDJEUEpaMzE2L2xpRCt0WHNHM1hYczAwMkRC?=
 =?utf-8?B?TDVoYmhGb09KTnNRT1hLVFgwYUsyRElpdUxxdVZacDhHWklCbHpVS1NuOUhu?=
 =?utf-8?B?ODIweVZ2c3VwZXNyTGpBSmpOSi9pWkF5QXRvTjVjQlVQTXpGVVlmd3J6WkRF?=
 =?utf-8?B?ZGp2eUdRVFhuYTdES2RJUUdWKy9Mc0QvWFBaajUySUZXNzQyYlhrQUpCYld4?=
 =?utf-8?B?ZHlITUdkU2VCZjhCWExYalVMenY0c1dRM3FPakU1RHZBL2FkVkdJWjZiWDZk?=
 =?utf-8?B?QXVoNFlpaksySklKOUdUdlNZMFhnaGIxVlRQb082M1hRWTludnVCL3YzcXA4?=
 =?utf-8?B?UFIzQkczemJyMnRLMmE2cDl2S3pGYi9IVlpxYlloRTFKQTNoNzkvT2g1dUtU?=
 =?utf-8?B?TVhJTEdnSlJ6U25NOWp5QS9JOE1zWXhTUEhucFRVZ0VaWXBQZXl3TjhDbGd5?=
 =?utf-8?B?c3plelltRHpsT0pVVURoNnAyUm9OdmlBQzB2Yzg5eXZoVEUrV2Nuc0RWZGNQ?=
 =?utf-8?B?YmlMbWJsUHNoanNPcWRMMGhkeEs0ZERmbi9UTnZITTNNRzEwTnFURVViaGdC?=
 =?utf-8?B?dGdGRERmaHEyM1RqYm5nVlErUWtkVkFWRm54WnErNVUxaEFSY3ZReWpBb2lK?=
 =?utf-8?B?bFl4bUVrVmZNMjhzMEpXc09ZRWZIb2doUElwNDBDdVdTTTlSNlMzSmlHaFFM?=
 =?utf-8?B?Y2U2NDY2REx1bEpsaUJNMHlhbS9zZWhPNUJIeEJVUDVzc3RFZUcvV01VeW5z?=
 =?utf-8?B?RU9hT1d2VnBDMUNLNjgvMUJMZ1FZOHNVVjJ4U0kwaFJBNUprTGZ3RHVUMjVH?=
 =?utf-8?B?K0VkdVRXa1doelBEOUdnUVRGU2V4eVdOODB4NFZEUUV3QU1rVGIvam5CT2dh?=
 =?utf-8?B?UnZrL2JxeWdsWHhKS1RzbEhndFlIZW9YQTFsek5Sem51bG11ZmRTTkZXY2Uz?=
 =?utf-8?B?V2g2SlpQaXhIUWRlSnZ3UFlzazVxV09aTUN0RldRNGdldG9VR3ROOHlSSUJ4?=
 =?utf-8?B?OCtSWFBhemc3bHc1clloaU8vbXRuYnlKdXZNTFp3NU1vOCtYNXNCTWZFb0JZ?=
 =?utf-8?B?bWdzMUhJV1drcGhkQ1RESkR4Uk4vTVFkRjU2eFVRNzZZN3lrbjJLV09zUFhH?=
 =?utf-8?B?K1ExUjloM0EwdVZHVmhRaitXeFp4OVUyOGdKRkViZ1BVT1NkZWRGdStaaFp4?=
 =?utf-8?B?QldHZnhrbFhVK2VVc25lZzl2NkRWRkdYVWtTNjVHTjJvd2ZhOVFLdUt0WURB?=
 =?utf-8?B?c1J1V29VTUFVYk1HS0l1OUR5VVRxU3lSWStTS1haS2ZsblNPL3ZWOVlPME1K?=
 =?utf-8?B?RmUvWVQycElHeVhqcXFDeWw0VG1YZlpHQi9WVVI0ZG16YVZlcUFUMzVoa1Ar?=
 =?utf-8?B?eFVYcVk3RklxeGxoRVlsN290WnBtZ2Y2QlNnTFFOTmFiRXU3cVNXd20xT3RX?=
 =?utf-8?B?eU5vVGhSYmx3MjRYam80R0FRTkZmSzltQ1RTUWVIUFA2NCtVaDYvWjNrY2Vt?=
 =?utf-8?B?NDZyekIyYks2NDQ0SnFoUmZRSXdhczNINE8ySWFxSlAzSFRhZ09YSTh5aTJl?=
 =?utf-8?B?OW55cEN5UmJUMHdiS25aSC82TGllRGFPMFgzR2Q3YmFiWlh2V1AzdnMyYkFQ?=
 =?utf-8?B?OGw0YkFXS2lLNThnNkJvazhQWEJHN3NQbTM1eW1TWkd3RGE1ZzZMYTEyNHc5?=
 =?utf-8?B?YVE0VDdRd0N0MWo3dko2alFpL0lkRk9DNCt0SzRzMkFCTStUTlBETk5NVlBJ?=
 =?utf-8?B?M0RZWFRMWHpWYkhDUk5qTCtNSm5OSktNeUdHZ3FoelZoUU84SnFvc1VNd1px?=
 =?utf-8?B?aG8xZmdjUFRXdVNOaXltY3Jic0VPWklFcmQvT0Y5VnpKcnFjN3VXVy9URlE0?=
 =?utf-8?Q?saaJLYB5qT58j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae48006-155a-4a75-1355-08d946c8a5fa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 13:09:44.3028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMirNoVOJ614OcTSvoXinMLPCgi4RkhwrsiBNx60vQ642AChPzUahc0qj6eYEGQz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2386
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMDcuMjEgdW0gMTM6MTUgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIFdlZCwgSnVs
IDE0LCAyMDIxIGF0IDEyOjUxOjE1UE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+
IEFtIDE0LjA3LjIxIHVtIDEyOjQ0IHNjaHJpZWIgRGFuaWVsIFZldHRlcjoKPj4+IE9uIE1vbiwg
SnVsIDEyLCAyMDIxIGF0IDA2OjA2OjM2UE0gLTA0MDAsIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+
Pj4+IEtGRCBUaHVuayBtYXBzIGludmlzaWJsZSBWUkFNIEJPcyB3aXRoIFBST1RfTk9ORSwgTUFQ
X1BSSVZBVEUuCj4+Pj4gaXNfY293X21hcHBpbmcgcmV0dXJucyB0cnVlIGZvciB0aGVzZSBtYXBw
aW5ncy4gQWRkIGEgY2hlY2sgZm9yCj4+Pj4gdm1fZmxhZ3MgJiBWTV9XUklURSB0byBhdm9pZCBt
bWFwIGZhaWx1cmVzIG9uIHByaXZhdGUgcmVhZC1vbmx5IG9yCj4+Pj4gUFJPVF9OT05FIG1hcHBp
bmdzLgo+Pj4+Cj4+Pj4gdjI6IHByb3RlY3QgYWdhaW5zdCBtcHJvdGVjdCBtYWtpbmcgYSBtYXBw
aW5nIHdyaXRhYmxlIGFmdGVyIHRoZSBmYWN0Cj4+Pj4gdjM6IHVwZGF0ZSBkcml2ZXItc3BlY2lm
aWMgdm1fb3BlcmF0aW9uc19zdHJ1Y3RzCj4+Pj4KPj4+PiBGaXhlczogZjkxMTQyYzYyMTYxICgi
ZHJtL3R0bTogbnVrZSBWTV9NSVhFRE1BUCBvbiBCTyBtYXBwaW5ncyB2MyIpCj4+Pj4gU2lnbmVk
LW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4+Pj4gU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4g
U28gbG9va2luZyBhdCB2bWZfaW5zZXJ0X3Bmbl9wcm90KCkgYW5kIHRoZSBjb21tZW50IHRoZXJl
IHdlIGNhbid0IGhhdmUKPj4+IFZNX1BGTk1BUCBhbmQgaXNfY293X21hcHBpbmcgZXZlciBiZSB0
cnVlLCBvciB0aGluZ3MgYnJlYWsuIE9uIHBsYXRmb3Jtcwo+Pj4gd2l0aG91dCBwdGVfc3BlY2lh
bCBhdCBsZWFzdC4KPj4gS2V5IGlkZWEgaXMgdGhhdCB3ZSBuZXZlciBlbmQgdXAgaW4gdm1mX2lu
c2VydF9wZm5fcHJvdCgpIGJlY2F1c2UgdGhlIHZtYSBpcwo+PiBtYXBwZWQgd2l0aCBQUk9UX05P
TkUuCj4gQWggcmlnaHQgaWYgaXQncyBQUk9UX05PTkUgdGhlbiBpdCdzIG9rLiBCdXQgdGhlIGNv
ZGUgaGVyZSBvbmx5IGNoZWNrcyBmb3IKPiBWTV9XUklURSwgbm90IFZNX1JFQUQsIHNvIFBST1Rf
UkVBRCBjYW4gZ2V0IHRocm91Z2ggYW5kIGdvIGJvb20/IE9yCj4gc29tZXRoaW5nIGVsc2UgSSdt
IG1pc3Npbmc/CgpBaCwgZ29vZCBwb2ludC4gWWVhaCB0aGF0IGlzIGluZGVlZCBub3QgaGFuZGxl
ZCBjb3JyZWN0bHkgYW5kIGNhbiBjYXVzZSAKYSBCVUdfT04oKS4KCkxvb2tzIGxpa2Ugd2UgbmVl
ZCB0byByZXZlcnQgdGhhdCBwYXRjaCBhbmQgZ28gYmFjayB0byB0aGUgZHJhd2luZyBib2FyZCAK
dGhlbi4KCkNocmlzdGlhbi4KCj4KPiBNYXliZSB0aW1lIGZvciBhIGZldyBhbWRncHUgbW1hcCB0
ZXN0cyB0aGF0IGdvIHRocm91Z2ggdGhlIGNvbWJvcyBhbmQgbWFrZQo+IHN1cmUgaXQgd29ya3Mv
ZmFpbHMgYWxsIGNvcnJlY3RseS4KPiAtRGFuaWVsCj4KPj4+IFNvIEknbSBub3Qgc3VyZSB0aGlz
IGlzIGEgZ3JlYXQgaWRlYSwgYW5kIGRlZmluaXRlbHkgbm90IGZvciBhbGwgZHJpdmVycwo+PiBZ
ZWFoLCBJJ20gYWJzb2x1dGVseSBub3QgaGFwcHkgd2l0aCB0aGlzIGVpdGhlciBidXQgaXQgc2Vl
bWVkIHRvIGJlIHRoZQo+PiBsZWFzdCBwYWluZnVsIHRoaW5nIHRvIGRvLgo+Pgo+Pj4gLi4uCj4+
Pgo+Pj4gQ2FuIHdlIGNsZWFyIFZNX01BWVdSSVRFIGluc3RlYWQgdG8gZm9yY2UgdGhpcyB0byBi
ZSBhIG5vbi1jb3cgbWFwcGluZwo+Pj4gaW5zdGVhZD8KPj4gV2VsbCB3ZSBoYXZlIGNvbnNpZGVy
ZWQgZm9yY2VmdWxseSBzZXR0aW5nIFZNX1NIQVJFRCwgd2hpY2ggd29uJ3Qgd29yawo+PiBlYXNp
bHkgZm9yIGEgY291cGxlIG9mIHJlYXNvbnMuCj4+Cj4+IEJ1dCBjbGVhcmluZyBWTV9NQVlXUklU
RSBpbiBhbWRncHUvYW1ka2ZkIG1heSBhY3R1YWxseSB3b3JrIGFzIHdlbGwuCj4+Cj4+IEZlbGl4
IGNhbiB5b3UgdGVzdCB0aGlzPwo+Pgo+PiBUaGFua3MsCj4+IENocmlzdGlhbi4KPj4KPj4+IC1E
YW5pZWwKPj4+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dlbS5jICB8ICAzICsrLQo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZl
YXVfZ2VtLmMgICAgfCAgMyArKy0KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9nZW0uYyAgICAgIHwgIDMgKystCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9f
dm0uYyAgICAgICAgICB8IDE0ICsrKysrKysrKysrKystCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJt
L3Ztd2dmeC92bXdnZnhfdHRtX2dsdWUuYyB8ICAxICsKPj4+PiAgICBpbmNsdWRlL2RybS90dG0v
dHRtX2JvX2FwaS5oICAgICAgICAgICAgIHwgIDQgKysrKwo+Pj4+ICAgIDYgZmlsZXMgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4+PiBpbmRleCBiMzQwNGM0M2E5MTEuLjFhYTc1
MGE2YTVkMiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2VtLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Vt
LmMKPj4+PiBAQCAtNzksNyArNzksOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZtX29wZXJhdGlv
bnNfc3RydWN0IGFtZGdwdV9nZW1fdm1fb3BzID0gewo+Pj4+ICAgIAkuZmF1bHQgPSBhbWRncHVf
Z2VtX2ZhdWx0LAo+Pj4+ICAgIAkub3BlbiA9IHR0bV9ib192bV9vcGVuLAo+Pj4+ICAgIAkuY2xv
c2UgPSB0dG1fYm9fdm1fY2xvc2UsCj4+Pj4gLQkuYWNjZXNzID0gdHRtX2JvX3ZtX2FjY2Vzcwo+
Pj4+ICsJLmFjY2VzcyA9IHR0bV9ib192bV9hY2Nlc3MsCj4+Pj4gKwkubXByb3RlY3QgPSB0dG1f
Ym9fdm1fbXByb3RlY3QKPj4+PiAgICB9Owo+Pj4+ICAgIHN0YXRpYyB2b2lkIGFtZGdwdV9nZW1f
b2JqZWN0X2ZyZWUoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpnb2JqKQo+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJt
L25vdXZlYXUvbm91dmVhdV9nZW0uYwo+Pj4+IGluZGV4IDViMjc4NDUwNzVhMS4uMTY0ZWE1NjRi
YjdhIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZ2Vt
LmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2dlbS5jCj4+Pj4g
QEAgLTcwLDcgKzcwLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVj
dCBub3V2ZWF1X3R0bV92bV9vcHMgPSB7Cj4+Pj4gICAgCS5mYXVsdCA9IG5vdXZlYXVfdHRtX2Zh
dWx0LAo+Pj4+ICAgIAkub3BlbiA9IHR0bV9ib192bV9vcGVuLAo+Pj4+ICAgIAkuY2xvc2UgPSB0
dG1fYm9fdm1fY2xvc2UsCj4+Pj4gLQkuYWNjZXNzID0gdHRtX2JvX3ZtX2FjY2Vzcwo+Pj4+ICsJ
LmFjY2VzcyA9IHR0bV9ib192bV9hY2Nlc3MsCj4+Pj4gKwkubXByb3RlY3QgPSB0dG1fYm9fdm1f
bXByb3RlY3QKPj4+PiAgICB9Owo+Pj4+ICAgIHZvaWQKPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9nZW0uYwo+Pj4+IGluZGV4IDQ1OGY5MmE3MDg4Ny4uYzE5YWQwN2ViN2I1IDEwMDY0NAo+
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2dlbS5jCj4+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZ2VtLmMKPj4+PiBAQCAtNzcsNyArNzcsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3RydWN0IHJhZGVvbl9nZW1fdm1f
b3BzID0gewo+Pj4+ICAgIAkuZmF1bHQgPSByYWRlb25fZ2VtX2ZhdWx0LAo+Pj4+ICAgIAkub3Bl
biA9IHR0bV9ib192bV9vcGVuLAo+Pj4+ICAgIAkuY2xvc2UgPSB0dG1fYm9fdm1fY2xvc2UsCj4+
Pj4gLQkuYWNjZXNzID0gdHRtX2JvX3ZtX2FjY2Vzcwo+Pj4+ICsJLmFjY2VzcyA9IHR0bV9ib192
bV9hY2Nlc3MsCj4+Pj4gKwkubXByb3RlY3QgPSB0dG1fYm9fdm1fbXByb3RlY3QKPj4+PiAgICB9
Owo+Pj4+ICAgIHN0YXRpYyB2b2lkIHJhZGVvbl9nZW1fb2JqZWN0X2ZyZWUoc3RydWN0IGRybV9n
ZW1fb2JqZWN0ICpnb2JqKQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9ib192bS5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYwo+Pj4+IGluZGV4IGY1
NmJlNWJjMDg2MS4uZmIzMjViYWQ1ZGI2IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS90dG0vdHRtX2JvX3ZtLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192
bS5jCj4+Pj4gQEAgLTU0MiwxNyArNTQyLDI5IEBAIGludCB0dG1fYm9fdm1fYWNjZXNzKHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHIsCj4+Pj4gICAgfQo+Pj4+
ICAgIEVYUE9SVF9TWU1CT0wodHRtX2JvX3ZtX2FjY2Vzcyk7Cj4+Pj4gK2ludCB0dG1fYm9fdm1f
bXByb3RlY3Qoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgc3RhcnQs
Cj4+Pj4gKwkJICAgICAgIHVuc2lnbmVkIGxvbmcgZW5kLCB1bnNpZ25lZCBsb25nIG5ld2ZsYWdz
KQo+Pj4+ICt7Cj4+Pj4gKwkvKiBFbmZvcmNlIG5vIENPVyBzaW5jZSB3b3VsZCBoYXZlIHJlYWxs
eSBzdHJhbmdlIGJlaGF2aW9yIHdpdGggaXQuICovCj4+Pj4gKwlpZiAoaXNfY293X21hcHBpbmco
bmV3ZmxhZ3MpICYmIChuZXdmbGFncyAmIFZNX1dSSVRFKSkKPj4+PiArCQlyZXR1cm4gLUVJTlZB
TDsKPj4+PiArCj4+Pj4gKwlyZXR1cm4gMDsKPj4+PiArfQo+Pj4+ICtFWFBPUlRfU1lNQk9MKHR0
bV9ib192bV9tcHJvdGVjdCk7Cj4+Pj4gKwo+Pj4+ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgdm1f
b3BlcmF0aW9uc19zdHJ1Y3QgdHRtX2JvX3ZtX29wcyA9IHsKPj4+PiAgICAJLmZhdWx0ID0gdHRt
X2JvX3ZtX2ZhdWx0LAo+Pj4+ICAgIAkub3BlbiA9IHR0bV9ib192bV9vcGVuLAo+Pj4+ICAgIAku
Y2xvc2UgPSB0dG1fYm9fdm1fY2xvc2UsCj4+Pj4gICAgCS5hY2Nlc3MgPSB0dG1fYm9fdm1fYWNj
ZXNzLAo+Pj4+ICsJLm1wcm90ZWN0ID0gdHRtX2JvX3ZtX21wcm90ZWN0LAo+Pj4+ICAgIH07Cj4+
Pj4gICAgaW50IHR0bV9ib19tbWFwX29iaihzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgc3Ry
dWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibykKPj4+PiAgICB7Cj4+Pj4gICAgCS8qIEVuZm9yY2Ug
bm8gQ09XIHNpbmNlIHdvdWxkIGhhdmUgcmVhbGx5IHN0cmFuZ2UgYmVoYXZpb3Igd2l0aCBpdC4g
Ki8KPj4+PiAtCWlmIChpc19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdzKSkKPj4+PiArCWlmIChp
c19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdzKSAmJiAodm1hLT52bV9mbGFncyAmIFZNX1dSSVRF
KSkKPj4+PiAgICAJCXJldHVybiAtRUlOVkFMOwo+Pj4+ICAgIAl0dG1fYm9fZ2V0KGJvKTsKPj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfdHRtX2dsdWUuYyBi
L2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X3R0bV9nbHVlLmMKPj4+PiBpbmRleCBlNmIx
Zjk4ZWM5OWYuLmU0YmY3ZGM5OTMyMCAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
dm13Z2Z4L3Ztd2dmeF90dG1fZ2x1ZS5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3Ztd2dm
eC92bXdnZnhfdHRtX2dsdWUuYwo+Pj4+IEBAIC02MSw2ICs2MSw3IEBAIGludCB2bXdfbW1hcChz
dHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCj4+Pj4gICAgCQku
ZmF1bHQgPSB2bXdfYm9fdm1fZmF1bHQsCj4+Pj4gICAgCQkub3BlbiA9IHR0bV9ib192bV9vcGVu
LAo+Pj4+ICAgIAkJLmNsb3NlID0gdHRtX2JvX3ZtX2Nsb3NlLAo+Pj4+ICsJCS5tcHJvdGVjdCA9
IHR0bV9ib192bV9tcHJvdGVjdCwKPj4+PiAgICAjaWZkZWYgQ09ORklHX1RSQU5TUEFSRU5UX0hV
R0VQQUdFCj4+Pj4gICAgCQkuaHVnZV9mYXVsdCA9IHZtd19ib192bV9odWdlX2ZhdWx0LAo+Pj4+
ICAgICNlbmRpZgo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5o
IGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19hcGkuaAo+Pj4+IGluZGV4IGY2ODFiYmRiYzY5OC4u
NDBlYjk1ODc1MzU1IDEwMDY0NAo+Pj4+IC0tLSBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBp
LmgKPj4+PiArKysgYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oCj4+Pj4gQEAgLTYwNSw2
ICs2MDUsMTAgQEAgdm9pZCB0dG1fYm9fdm1fY2xvc2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2
bWEpOwo+Pj4+ICAgIGludCB0dG1fYm9fdm1fYWNjZXNzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLCB1bnNpZ25lZCBsb25nIGFkZHIsCj4+Pj4gICAgCQkgICAgIHZvaWQgKmJ1ZiwgaW50IGxl
biwgaW50IHdyaXRlKTsKPj4+PiArCj4+Pj4gK2ludCB0dG1fYm9fdm1fbXByb3RlY3Qoc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgc3RhcnQsCj4+Pj4gKwkJICAgICAg
IHVuc2lnbmVkIGxvbmcgZW5kLCB1bnNpZ25lZCBsb25nIG5ld2ZsYWdzKTsKPj4+PiArCj4+Pj4g
ICAgYm9vbCB0dG1fYm9fZGVsYXllZF9kZWxldGUoc3RydWN0IHR0bV9kZXZpY2UgKmJkZXYsIGJv
b2wgcmVtb3ZlX2FsbCk7Cj4+Pj4gICAgdm1fZmF1bHRfdCB0dG1fYm9fdm1fZHVtbXlfcGFnZShz
dHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgcGdwcm90X3QgcHJvdCk7Cj4+Pj4gLS0gCj4+Pj4gMi4zMi4w
Cj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
