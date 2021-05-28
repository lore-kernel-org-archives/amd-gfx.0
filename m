Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83F4C4708D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 09:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23DE613F1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 09:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23DE613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169EC6E34B;
	Fri, 28 May 2021 09:47:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298776E34B;
 Fri, 28 May 2021 09:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQ1ARocrLXMOn0mAHrTZ8jy54nFc/dcdhq7Q6MV3Nv8msFlf1ZGFLzbnankpCX/srhVBboY/o6B3HqQs6Re/0Y+ct9cWfyADQnN+0TtvUVdRxpZhXF8bz7sRgBXNGd1PjnYepipmlsr7tLqrwTPWAg0+NUqR/KhdLPVzI3rLmZN0yt4nzDU8yfV8HFMEMU62fb8/3VDur3fMlmBwg6mWfDoyabPyT11IrHL+VExhjPFh2a7AfszmECSMQ0ZTtsoJLGnnXGp/rlt5c2IOujM4XzZ37px5Dx+3HV6k27K77fJGSwy1Wcq84kgOyH1C4ejkk+k1hC+ii6HbsPIdlSJeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/wcby+t+zMSKcuedqEDWtrxSCQecR85EnoYGVAurRw=;
 b=N67HuruzZYyYT+XZeV8J4zyIQH+g07I6kvltof0/F6y4Lon5t5Hvci63obBCEcnnBBYDziL0m11kMc3ev0OKpGfQy47Xl7ErmiXq5wLGbGdVuPJ4DzWvSYyeXOxyOKATqW4+Uq7jwPyfdV6PXTLB+ZoCsQaHWf3VEamQ4Ym6JMKEjKR4m7nndzM8ZIUltx8ajy15tjabVzzzRZUwxzIMTuhL3gohLBg1q5b0ja+foJGZN9ABqZ7AWOp1Z/BHyRkJdRuYxprUa7f6zQAgAakol5ln7y5WfFe5MaQpoPNtfAyi/7xjeDArUHOBw27qGrl1V6X6gTykNsunKNrSvJGWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/wcby+t+zMSKcuedqEDWtrxSCQecR85EnoYGVAurRw=;
 b=JLgyNu/xPCMxKLdWVd5U9ICFjM8lP/FPDLnsvFcQpvt99Sj/DqwbFsLCfDMeUpJfQh4eV9PzlXV942//OqEDC9w18JmJBXbbpEB4E8NwwYDpExSa/b2Ed274fwoVSO0NAXzzl4+iwrmGRs2osZzvp7233Ga/XJpABH1h1aSPuSw=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Fri, 28 May 2021 09:47:33 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::a4b1:38b7:ec94:8003]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::a4b1:38b7:ec94:8003%8]) with mapi id 15.20.4173.021; Fri, 28 May 2021
 09:47:33 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: stop bookkeeping of temporary GTT
 allocation
Thread-Topic: [PATCH 2/2] drm/amdgpu: stop bookkeeping of temporary GTT
 allocation
Thread-Index: AQHXUpf9PQ4MN+fgUU+PeYLsfjiDkKr3OA+AgAFl4jA=
Date: Fri, 28 May 2021 09:47:33 +0000
Message-ID: <DM6PR12MB4250A3267C2472E9F4170F0EFB229@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210527013051.4302-1-Lang.Yu@amd.com>
 <20210527013051.4302-2-Lang.Yu@amd.com>
 <8539c291-85e8-7530-af23-505cda7871f9@amd.com>
In-Reply-To: <8539c291-85e8-7530-af23-505cda7871f9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-28T09:47:30Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=be7992ab-0f87-4618-b6c4-df586a8727ec;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1642707d-24b8-498c-2163-08d921bd9e41
x-ms-traffictypediagnostic: DM6PR12MB4513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4513447C11D4272E4BB6338BFB229@DM6PR12MB4513.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DbeO3ZZ/sx18d6VjOahElCgrzrL6F3GY1WOfs2EuXr7afGxG3L46lvCTOHPVzZKvgvP0F9H9ou45GSy5KSLUjJKDZLbsS2hOYCI9EU+I/uslFcNPRIL0tDu908QmITVnZZKMPYjzvhmKRJMWQkG+rahirs8YTEeI1XCbu7s0if5atk8v9N/YnugjX+qzgkxsYXZamF+xHogwwSQrnWhrpCh9tqz+WRnLDMCWuNAM1Mj8h/gO4sHGEO/jlUFTE4QJaCf/Ilzr9Alk6tzClZ2lEEOOyo5pwiUHOXpnr+af4mI8wSi5bVJQezRdzYfA5A+E9gKM0XiZ1gFNcZcaPYPSYEMZ67bxFNIiVp0DPTwt9g1bi8zGMQTfkNtHzc8HlViOp05M59ieBPLsQvAIowjKhFKEQHkNJQ1zKUNhVZWQmi89Lz2nhCNSKlhES23UXpQdQejeXR1swdRQOJkH9cH77+4KCZBL8WexYoi2MDmK7LX6qxW7cgG0/x6dEKockpWXP2b40XcILJz4wMGYXbmwkj+SALDz3qMMK3nwULBFLIFCrDb7V/1R0yHqu0FNu5kBB8tVr4CHimEgSnAyyA9aQaY+0qbgLskcX8283wDl7qQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(64756008)(66556008)(7696005)(66476007)(6506007)(8936002)(66946007)(5660300002)(52536014)(9686003)(186003)(86362001)(450100002)(66446008)(33656002)(76116006)(122000001)(38100700002)(55016002)(478600001)(2906002)(83380400001)(4326008)(316002)(71200400001)(26005)(54906003)(8676002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MzJoTFp2SERaZkhCNXkwSXRxWHlXV2tyMHVZd2JJUWxCbytzWVBaY1hKRWlK?=
 =?utf-8?B?NkJpSXNqR253ZkJSNUZQZlNHTG92V0ZCM1ExMEUrenRCbVNscG1IZnhTU1Rm?=
 =?utf-8?B?T0tkTkYycS9wcVMzaE96WjAzcmw5SzQrZUxuZHF5TjFEUThDbG53V3pRckox?=
 =?utf-8?B?bnJORDlvUUpBTWRGOHpheGIrdmNRbVM3b1J4T082eHRGM0h0RzNrZWQ0d3Vi?=
 =?utf-8?B?K3ZadTZ0NFVLaHBDeUhEK2ZRZWY4ZDV2MmIrTDY0akxlVitZZCtMYWxMVlND?=
 =?utf-8?B?Snk4REJOWEhKQk9IZGM2ZWJObjcyRVJicm5kUGVtMS9uYTJROGNiV25pUytC?=
 =?utf-8?B?elUxbjZZRnJsUERINS83dm9pZ0RCQXZNOVBpTGR2cUN3dDNXUmpjU3FKdS9N?=
 =?utf-8?B?Q3ZhMDhGZUY1SmpydjlZeVBBaElWMzM2bXVZK1FRTnFqK3JObjEyTEdsOGwx?=
 =?utf-8?B?RGpqSGthZXFoQ0xlcEZiaVlVdW9zblIraHRVWkxXb2k3UmlOMTlyVlpIVnFP?=
 =?utf-8?B?M04xRHJuS2JhMnpLVXdBSHBCS0cyaFAyM2JiRU1mSGZzelk1Q0NxVkVOb3RJ?=
 =?utf-8?B?U0tIMlZ4UjFUU1VSOEp4ZksxSlhNSmhESThBUEh2WEJTVVR3NDlST1VLRkNB?=
 =?utf-8?B?UHNWTDQ4bVRyK0YrS3E3eC9ZbG1JbGpjcnZDdXJqMHFlUTFGNlVTRWdtSTJi?=
 =?utf-8?B?L0NSNHpyaFB0dVR2ZXB3MUR0MERUR040NmJSbjlwOU1WMlB0SnhxWTBjYjhN?=
 =?utf-8?B?OVovczliUGg0ZElrWVNQZzZ6TVJqTldvN2ErMkdsWkM3azk0cWY3QUJBN3Uz?=
 =?utf-8?B?NWJKTURpZTdzYlNXL0pCSGw5OStxZWZzdTQ5eHVOQWNpK2RyZFExMytJa2Np?=
 =?utf-8?B?eDFjVFU4VmMxR3FQbXc5RGRhUE03azR6RGxURm93Zjl5R2NoM1pYdkt5TEY0?=
 =?utf-8?B?cmI5d2dteWNIRGk4UklhWDNlRjBZdmh4RVN3dXAvWkxkZ3pjWXE2andFOWNu?=
 =?utf-8?B?dUtybEFmK3F3OGlLUWtPakNUUTBsUU9oWXFDdHlWWXgweFNHN1ppU2RJVnl2?=
 =?utf-8?B?b3hPcnU3UzgxbFJmQ3Jpc0FLUkdidUlyU1p2dU04Mm5WVXk2YzF2eWtmV0NC?=
 =?utf-8?B?ZjREOTFIZHdNUTdBYWxDMmxVZnVPQ05oTk8vU0tmdDVtaG4xei9Ba3Y3NlRM?=
 =?utf-8?B?N3BHZnZOMlUwbFNNUmF2MGErblVOdDM3YXEvR0lkVzUyd3U0ZXlaT3p1OHRG?=
 =?utf-8?B?NktMYkFvZFo3U0lBNzVQUHd6R3pmMnB4RzU0Y2VlT0pjVVBjekFnTDRPL0RW?=
 =?utf-8?B?VXJRL2ppSzZKOHR0OWVLa3VEQ0gwSUczY2o5V0NIeFdhMWgwMnRReGcyWVpt?=
 =?utf-8?B?Y0VERXI1Y3B4TEY4SHI2U2NOenZ1dU5CVWtSek1IRlZRci95WFpYbFdRNmVS?=
 =?utf-8?B?RVdjdEFUUFB4QW05SkRSKzlPMU9LVUN5bGZuYnlWWEhNVVlZZ29zT0RLVi9q?=
 =?utf-8?B?OTdPbjV5b0xWSit5cVF6amovYitHTmZabk1SeVNtRVhkc2cyMkpKQ2U2anJj?=
 =?utf-8?B?UVE1eFpiS3VFNDBGUmk0S0hXSWRMUHZVV29zUkpjcHo5VGg2REdyWW1mUXBa?=
 =?utf-8?B?Q0c3NU1vQUF3ZW53a1Znb0FyYXpRdEdwTDZLaXVIZVpHZzVDZjZET01IdUgy?=
 =?utf-8?B?SjVvRndTV0YyYktZbGRNQWs3d2liUkhqSmxLQldtSUxHbWJqbktnN05TSXRh?=
 =?utf-8?Q?eqp8Exu/SJRPq2Zoqs0b6VYvU+i7wNFhPoa84tw?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1642707d-24b8-498c-2163-08d921bd9e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 09:47:33.5447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebK+G0Hkvgd4kBtErQPoUAvaVSvQnfZ9992UzJGE09O1XBCb8MxWRDsF7lOTXbtWBtUZSQJMTzAb0TnnVz8+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]


Inline.

>-----Original Message-----
>From: Koenig, Christian <Christian.Koenig@amd.com>
>Sent: Thursday, May 27, 2021 7:51 PM
>To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org; dri-
>devel@lists.freedesktop.org
>Cc: Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>; Olsak, Marek <Marek.Olsak@amd.com>
>Subject: Re: [PATCH 2/2] drm/amdgpu: stop bookkeeping of temporary GTT
>allocation
>
>Puttin Marek on CC.
>
>Am 27.05.21 um 03:30 schrieb Lang Yu:
>> To improve buffer migration performace, stop bookkeeping of temporary
>> GTT allocation, including allocation for BO evicted from VRAM and
>> bounce buffer.
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 16 ++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  4 +++-
>>   2 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> index 8860545344c7..32fedd495c7f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> @@ -111,14 +111,15 @@ static int amdgpu_gtt_mgr_new(struct
>ttm_resource_manager *man,
>>   	struct amdgpu_gtt_node *node;
>>   	int r;
>>
>> -	spin_lock(&mgr->lock);
>> -	if ((&tbo->mem == mem || tbo->mem.mem_type != TTM_PL_TT) &&
>> -	    atomic64_read(&mgr->available) < mem->num_pages) {
>> +	if (!(mem->placement & TTM_PL_FLAG_TEMPORARY)) {
>> +		spin_lock(&mgr->lock);
>> +		if (atomic64_read(&mgr->available) < mem->num_pages) {
>> +			spin_unlock(&mgr->lock);
>> +			return -ENOSPC;
>> +		}
>> +		atomic64_sub(mem->num_pages, &mgr->available);
>
>After sleeping a night over that I think we need to talk about this part here once
>more.
>
>While temporary GTT allocations can temporary exceed the GTT limitation we
>still need to account them in the case the eviction is interrupted for some reason.
>
>In other words what can happen is that we want to move
>VRAM->GTT->SYSTEM, but GTT->SYSTEM never happens because it is
>interrupted in the wait (that's unfortunately rather likely).
>
>To solve this I think we should do the following:
>1. Change mgr->available into mgr->used (e.g. invert the value).
>2. Always account all GTT BOs to the used space.
>3. Only when it is not a temporary allocation bail out.
>
>This way temporary allocations are accounted for, but we still allow
>memory evictions to happen under pressure.
>
>While at it you could also drop taking the spinlock to check the atomic,
>that is pretty much unnecessary.
>
>Regards,
>Christian.
>
[Yu, Lang] Hi Christian,

Yes, it can actually happen that the BO was evicted from VRAM to GTT domain,
but was not moved forward to SYSTEM domain. It resides in GTT domain 
waiting for next time validation or eviction or destruction.

It is reasonable that we count all GTT allocation. 
1, I find if the temporary GTT BO was not counted but used for command submission, 
then we can use more GTT memory than GTT limit for command submission. Is that your concern? 
2, Or if we don't count temporary GTT allocation, that will mess up gtt manager.

In other words, if we don't count it when it resides in GTT domain, what is the consequence? 
Would like to know your concern. Actually it is counted by ttm_pages_allocated. 

If we use "used" instead of "available" in gtt manager, the used size may exceed man size.
We should also deal with gtt mgr debug interface.

Rework the logic like this with your idea:
	
	if ((atomic64_add_return(mem->num_pages, &mgr->used) > man->size) &&
		!(mem->placement & TTM_PL_FLAG_TEMPORARY)) {
			atomic64_sub(mem->num_pages, &mgr->used);
			return -ENOSPC;
	}

Regards,
Lang

>>   		spin_unlock(&mgr->lock);
>> -		return -ENOSPC;
>>   	}
>> -	atomic64_sub(mem->num_pages, &mgr->available);
>> -	spin_unlock(&mgr->lock);
>>
>>   	if (!place->lpfn) {
>>   		mem->mm_node = NULL;
>> @@ -178,6 +179,9 @@ static void amdgpu_gtt_mgr_del(struct
>ttm_resource_manager *man,
>>   		kfree(node);
>>   	}
>>
>> +	if (mem->placement & TTM_PL_FLAG_TEMPORARY)
>> +		return;
>> +
>>   	atomic64_add(mem->num_pages, &mgr->available);
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index c0aef327292a..129d39392859 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -152,9 +152,11 @@ static void amdgpu_evict_flags(struct
>ttm_buffer_object *bo,
>>   			abo->placements[0].lpfn = 0;
>>   			abo->placement.busy_placement = &abo-
>>placements[1];
>>   			abo->placement.num_busy_placement = 1;
>> +			abo->placements[1].flags |=
>TTM_PL_FLAG_TEMPORARY;
>>   		} else {
>>   			/* Move to GTT memory */
>>   			amdgpu_bo_placement_from_domain(abo,
>AMDGPU_GEM_DOMAIN_GTT);
>> +			abo->placements[0].flags |=
>TTM_PL_FLAG_TEMPORARY;
>>   		}
>>   		break;
>>   	case TTM_PL_TT:
>> @@ -538,7 +540,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object
>*bo, bool evict,
>>   			hop->fpfn = 0;
>>   			hop->lpfn = 0;
>>   			hop->mem_type = TTM_PL_TT;
>> -			hop->flags = 0;
>> +			hop->flags |= TTM_PL_FLAG_TEMPORARY;
>>   			return -EMULTIHOP;
>>   		}
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
