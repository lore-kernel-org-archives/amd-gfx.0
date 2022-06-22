Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AE1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 13:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCA1010E02A;
	Wed, 22 Jun 2022 13:34:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74F910E02A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 13:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOsnqFMNc6UFMS74fO6q35fWpDgmTq7DYcRRTIVpCRZG2cPc1H5XpjPto+X9Z7Feu1c1wEy2dDij/xLByqUk2Q/NKBHkjaDbXmxIVYWshou9avCLXU4TFPLmAK139OtZg0QG9Ymfy1eItFwWb3q4erCB6Wa0Qh+HnKEkF6oLr70U8Rl4w87G1bahB88p0DgGU+IsNmW9yJOGRs4+BRqY7Zd6/r3V1vzP7QCk5yHmgVKi5bz/oY7gIziPCPiok8FFW2mSGaSJN4I1JDJaL0/Da6ERM9ypvPCCk9OF9dSYjvHpmnpZlZZHN1HzsM8Uf4myolST4PSq6QoMHndR6tbaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwVLwBbz1AYLZEemK/ZINsNjRioaC+7X6e1XnII2jDI=;
 b=ZDTRDc2aHLvY633OAWvl18XMepe3Ji7x9DLBYPFA7m1mk/XxcQWkBOMRF1BR64m3MtW3bkiXAwnfLHRXjZ0pBM1Uk8fqye4WkYs1LqaKwGcVceZ93BrUVm+wmMbyT9DWjT9x/7tyxU69MXwwTzAWaBttPMvJLPJaqnjHzj5DxgsCdhZjLJvSx6H8vg8u4crV0ZWmi1wnjyHD8eZF5WOBvf3vFGpTNCP2Srhko7KTL61eDvGmUP8vBUx2ScyVBbwI4CMWhZO9TdPqMljIQjUV6TNk61+AdsRe07e9ridmwnb4+YXAD6FfL+zMDbUoWY+iYQ6gcs4fKvi55vCE2v1krQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwVLwBbz1AYLZEemK/ZINsNjRioaC+7X6e1XnII2jDI=;
 b=zQSG16UNd8rdpszy9X3xxogO+FjM96s7vusqNtsgNXbG1sHcHTdAifbXDTucj5334xEzE+hyh1fbnT27UqY+48e2p/G/2LH0ueIH2qWMg7YzBF2Hmf7I2oZVUOuZqOgtI3Fst6MCyCW7mdlsOlGL1Qcxurs7qs7ROjf3MYNF7lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 13:34:36 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 13:34:36 +0000
Message-ID: <32971f54-72b0-d74d-84d2-f7a6bc233199@amd.com>
Date: Wed, 22 Jun 2022 09:34:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] mdkfd: To flush tlb for MMHUB of GFX9 series
Content-Language: en-US
To: "Ji, Ruili" <ruili.ji@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220622064553.526856-1-ruili.ji@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220622064553.526856-1-ruili.ji@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:610:118::35) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 538cc87f-096c-4d99-05a3-08da5453f2cc
X-MS-TrafficTypeDiagnostic: MN0PR12MB5929:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5929D58C022C8D8F3CCF731DE6B29@MN0PR12MB5929.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5KFx/Z3D7/HTxhB6n1lLIUjHxqhzmrgFJQJwckDmHl+D+4yT9nd4nyyrLXY7DRlFmChMpGzjNsXzmsc3jeh6uSX3z9VKq2h96lh442C8dYcQML+z0XYm/ATpfB+VFC2epwQjlq/oWEzcXWC6ZPQTBxSdwYszUIrznpRiifov68/IYTYhtB4YZ7zzYHYnZCjGVcIYF7aR0QgVMCk7l9mGVeG70DnFKe6+8vRh3urINNn9JIyWMxblCnn82KPx20+ktSmG6hRFf6+6sHwV13DYMjpxbdZiYVhEfie2St8m+AZG3WLgA3Ncm6uEofxOSbO+k90dRKZan93TMZlL4H5ZlJLBf00Ry2HjYTrSh/MZqIlKORwdoTsz5q6Aw7M9OKadg+4LksXLKc9/o/c3X50SpbDMHrosX8WW+dIe0T0hf7W2sHjE+gSBboim1JeZ8dr1EQfDczNwMbDjnBWxJHXqMR94LcSES/7USEv1tuAdQqcZNuoV/1CqipDKYjsDjwqxRHfgRf+LD+DJToTT3+3utysIEfc2T6mAkcAA2T0r75HAZkwtiIuNQ5Mtl9DPvq60wwf5xkmnlNIX00P/Alz4tAJxIVlcdB8i0fWol4TMxuZSULb0WNFvEVofYaA4s1QMwCTh3Iog61XCy/OrMg7SycG89PGrlvxOj3b6X4LG9UcvMJXW3M0QwdLQAkMRdw5mntXNjWOB7+Ejb3rbiyfnyK/httxe0kSfAwtsBKweDRoIg7xldYDi3OJ8DnT9BmYZxxLevUD6xB9jzqZyNS5UsEUMXkd3EGrKfwLwjTYtRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(8936002)(53546011)(6486002)(5660300002)(54906003)(478600001)(6512007)(26005)(6506007)(31696002)(2906002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(8676002)(4326008)(66556008)(66476007)(31686004)(66946007)(316002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTREdXRjakZJaXZDVU9lYlpjbGJzSG13Yit3b2N6Q0FUajJ5R0VFM3U0VHN2?=
 =?utf-8?B?V0RkdGEzOTRIT21jbHZHR05KZEtjYXRoYmNlcTdxSUxxcHlUdVdTYkI2RTZh?=
 =?utf-8?B?OGlwMzgrZ1VWMHBZNU51c0NNYVN2VTY0RlVZbW1SZm5uYVBoNnYzcldRUld0?=
 =?utf-8?B?ZVQ3RjFTdlNCS0NmQUlkTWNhMzRKNzdXeGtpTXRJR0hsNTJiRWoxemZadzBP?=
 =?utf-8?B?WHd1MWdCaHdveURidWRhSW1pa1Y5L2UwelU2eXZRaWluU0wzS0lNZ2krcDJ0?=
 =?utf-8?B?Yldxb3RZcmN4NTliQ2V0d1N6UGpXZURNMmpoTVNhckNiR1ZxTFRlQ3EyekNT?=
 =?utf-8?B?V0YyYzMwVTdYSnBOUDhIMFY0UVp2RHc4VnFTUFl4Qmluek9aMmZ6RkQ1TjM2?=
 =?utf-8?B?VHBoRTQwcGtZVUlsU3g3bVFSTHExMmd0b1J4ejJMTTdydWlqNHZXWmVzUXlk?=
 =?utf-8?B?MkVXcUhDTnhlSTUvYTlwRnJFOHpSSGZIdEtreGhOQ0VscndKNjBrOVJ1d0Vo?=
 =?utf-8?B?cGNkWnNjMHBod1lWNGxYZnlTbjd4QmRkcHg5V0NMUmVsTW5HWlJtaFoyRHpM?=
 =?utf-8?B?VlhzUzZRRGMxR3pwTjNrVjBDciswRnBxTE1WZXZRRUM3MlpiaDdGQWpCa2dS?=
 =?utf-8?B?Nnd3MnRvQTBpdlhTckpZckNmKzNtYmtjZ3FvbHdTUERURGMveTNTZFl4TFBE?=
 =?utf-8?B?aUN1OHo5bDViK1FNbjkwc3ZNdzhNOHdlckNYKzQzalRvN1JtSTNESnAzalI5?=
 =?utf-8?B?RWV6ODk0dCtOSDlNWUVkTGNLYWRyUjNkVmJEQnQwZjUydHQrUFhjU1pTTUlW?=
 =?utf-8?B?NjRwWHVzaFRBUnE5OTVFUWpBWnQ1b3pLenBMTjQ5SDNTeWJVMHVkVUVvMEEz?=
 =?utf-8?B?MCsxTHE5V25XMmtKTk4ycWxvcHVJRHgzU0lCVFZkL2p2VzhORkxXR1BtcVJO?=
 =?utf-8?B?WFpNSG5tNE1TbTM3YkwxS3JOQ1lDVzZ1NjBxUXNuSmdGMHVEK2NYUTFPWERt?=
 =?utf-8?B?eDJRdEJGNWFheUFVQXc2YVUrOENFMUcwdW82VEMydHBpaHNLRHdFWUo5ZnFm?=
 =?utf-8?B?QXRlOWoxcFRIbzVRTG10LzlvRERTOCtUT1FSRkpsTEdCeForcHVRVUNTTzZM?=
 =?utf-8?B?dHpBZERGWC9qZWQ1TzViVUgyUFFaa01pK1JjWWhOQkJMVVd2NGM2a0U1d1pD?=
 =?utf-8?B?NjNpVHJ2Tk1PS3ZUMS9rTjFGNEZQTkxuWmZtblNKQnJOWVRlMTZuT3cyVUxG?=
 =?utf-8?B?UGxYbzljTDcvMVk3dlRDbzhOcFNOc3NoemN1eDVPUXhjV3dycEdkWkJnTXhB?=
 =?utf-8?B?QnRKMXptY1N0Sis4TjNuYit3Nzd3TzJNcXc5L0FxM3pqL0VhdElzaitzUXNr?=
 =?utf-8?B?bU1TQXg3czM3cnhETWNPcUZTYy8xRE9qRTZBa2cyVEZLSE00WHBzbEFPNjZk?=
 =?utf-8?B?eHZuZjdMTnRmZ1R6VTBCaW5OeWhVaHdIdFVNQjZWUG9XZUh5RTJLdFdBNE9q?=
 =?utf-8?B?R3ZMTVl6MDU3OFUzVUNvZGtiY1huS1lENUFtd3Btd3hnUjRkY0grU0lVTGsz?=
 =?utf-8?B?Unl6M05mTHN2T3BnYWlyZlhXdmtBelRNZ1IxVklNaHRDWUNUcEIwb1h4cDBh?=
 =?utf-8?B?cElEa0k3K01DdWljSlpLU2phdGtPbVdMZG5hRFA1Ykh3UWIydHVLZ0RibG1H?=
 =?utf-8?B?Y3VxYzVydzF6eUxiVGhCKzdOVS9ramRJdlM1cVVTUldhZFpLVHgzYWxleVNV?=
 =?utf-8?B?bGVTNUJxNVF1WmR6ZEkrVHlSMDQxcHJmVGdWS0lSazR1T1hFWUtsSm5ESW0v?=
 =?utf-8?B?cnRqYm5EV2dUcm51bW9iOWthV05SalFiWTNVRnh3d0dHamxXMmFoRitLTTBE?=
 =?utf-8?B?eGpzNUhlQlZxVDdCaWxyeWl2WERKSXJLRUNkeHJCaWI0elEyTE1EdTRmUER6?=
 =?utf-8?B?dzFGampEVGJlK0FEYXllc29ablN4OWNvN0RYUFUrcU9JLzBPTzBadFloNWZk?=
 =?utf-8?B?NXFkakpJWUdVc3BYWHhZM3pCaGk5cHNzM0lLZkdBNTVzN1ZFK1pSUUNnY1Ft?=
 =?utf-8?B?WkpQZCttanNzaGhFaHJZOWw5b2pKYXJwVGRZWFpBa2dXcGE0MTVWN2kxdjh3?=
 =?utf-8?B?U3ZtYnZMZDcyWGJVbUxBQWI1cFNYeXkveFpwMXowSUJiOEhSUUR2MjgvZFZC?=
 =?utf-8?B?T0VoNlV0VnlKWnJwT1JrV09aRGFFSmkvckNIQnNhV1c2eWJMbHczUkdnVlN6?=
 =?utf-8?B?M1lOejBjaWFickMxVlE0MWEyT0xrcThTaU9sMVU5eDRHaFVTcUFpdVYyY3Fz?=
 =?utf-8?B?YUNkV1M4RUtEY1VmYlpveXdBdS8wMHhmRHJ4V2dyUVNRcWkyOUcxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538cc87f-096c-4d99-05a3-08da5453f2cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 13:34:36.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yG8KcJ2gVU+FHWqs0OjkgOASwkqbN3ntwmGkpNgvvwC+SmbBX6TJ4In7d1ucRB9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <philip.yang@amd.com>,
 Ruili Ji <ruiliji2@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-06-22 02:45, Ji, Ruili wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220622064553.526856-1-ruili.ji@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Ruili Ji <a class="moz-txt-link-rfc2396E" href="mailto:ruiliji2@amd.com">&lt;ruiliji2@amd.com&gt;</a>

amdgpu: [mmhub0] no-retry page fault (src_id:0 ring:40 vmid:8 pasid:32769, for process test_basic pid 3305 thread test_basic pid 3305)
amdgpu: in page starting at address 0x00007ff990003000 from IH client 0x12 (VMC)
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00840051
amdgpu: Faulty UTCL2 client ID: MP1 (0x0)
amdgpu: MORE_FAULTS: 0x1
amdgpu: WALKER_ERROR: 0x0
amdgpu: PERMISSION_FAULTS: 0x5
amdgpu: MAPPING_ERROR: 0x0
amdgpu: RW: 0x1

When memory is allocated by kfd, no one triggers the tlb flush for MMHUB0.
There is page fault from MMHUB0.

v2:fix indentation

Signed-off-by: Ruili Ji <a class="moz-txt-link-rfc2396E" href="mailto:ruiliji2@amd.com">&lt;ruiliji2@amd.com&gt;</a>
Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1d0c9762ebfb..1dfd82d5d379 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -739,7 +739,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 {
 	bool all_hub = false;
 
-	if (adev-&gt;family == AMDGPU_FAMILY_AI)
+	if (adev-&gt;family == AMDGPU_FAMILY_AI ||
+                 adev-&gt;family == AMDGPU_FAMILY_RV)</pre>
    </blockquote>
    <p>Please use indent tabs plus spaces, seems here are all spaces.</p>
    <p>Just notice the typo in subject mdkfd, actually this should use
      drm/amdgpu as the file modified is in amdgpu folder.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20220622064553.526856-1-ruili.ji@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		all_hub = true;
 
 	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
</pre>
    </blockquote>
  </body>
</html>
