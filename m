Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB064C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 16:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F72C10E5B3;
	Tue, 21 Jun 2022 16:50:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F52210E5B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 16:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLWoA4hBI/vErcjUvI/LVKvRKCMqhJlrlrMZies7DWTw+JUPdcprHxIu/cLx2J9sP8M//s68+Ng3h5eae82+/T23faLmxMgxTC4coIBX+RyVLw3GKgA/t4Gm6z8MVTOsTF6PSt/IOB7oe1QZjcT97n9Ssl5WtuF7hqutu28oqKirF2rL4q3XdDGDs5WXqizp+X9RPSvnd/F+vw7N7i2Oh6UThInksnjk9J7fkr0GpnJK5FxhhySC/uY0dVE3MIZId9a69PMligjjnKivy7HfkaEQD9HstKa7QZLTJNVCL2eKLD/V7IksJbv4xRLY+ck8R+ypKnXgm9gyAMv0tgjFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X3398VKT3baI0wU1e9dNjC9CqPEIGadVJ5OTYLr7Rg=;
 b=J4WE2fuH+uBFTFYqb5ToEKOnAuHJjX+TVjYjTCWGiXFHe2GV2WdRg94G0H+QwA7M3cZv4+Bdt2FwSuT7Q/BMsWXtzjCWW+4mHEkTmRivxXAPuMbdnUUsSDEBuE2ZmMvkX3gh1jDw2tDRiP6M8l0EYBOUtNddwy/2AuwZVnkSEvg5ZVZ9ZHYz2+RYwR0RmaZwmOv6lLhkMaofGzjtWeWo/quNM1rhhWfJ1zbHFdCo0uKUZ84WxRgbiARs/w2AnH94QtWX6LIGHXK2y6OgqH29oD/COJIbGiIqqyTl+Rz5Hx1hDIbfoGsmj2qgC1mR3dyoRrOWjGCqvcdavzdbSTFoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X3398VKT3baI0wU1e9dNjC9CqPEIGadVJ5OTYLr7Rg=;
 b=JInH9ubzxMC0ic3Z7B10KNW+G4fc60hrdj1qQQ3q51jOEeEdT7iSDKcP3KmaP+Z8FdCmA3QYrumeOHvIteko+Z4/S71y0YVMpqDkamT62lGyqHbUdb43bjVNyzitrSz0lQEYOUbkw+aROejN2IaUjwJh8HTl/WpXw9B4YbRslXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BN8PR12MB3075.namprd12.prod.outlook.com (2603:10b6:408:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 16:50:39 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 16:50:39 +0000
Message-ID: <e95287a8-4d9e-6622-cd31-a9a3ecdbcde7@amd.com>
Date: Tue, 21 Jun 2022 12:50:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: To flush tlb for MMHUB of GFX9 series
Content-Language: en-US
To: "Ji, Ruili" <ruili.ji@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220621022550.492588-1-ruili.ji@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220621022550.492588-1-ruili.ji@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eac0c41-022f-4c10-aca1-08da53a62be4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3075:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3075CCDCFF1F869CC56FA418E6B39@BN8PR12MB3075.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JB10E4BiK4juoVWg5+zOKPXS/fZVs2El1Cogyti/DJXZRILLt+pCJPnCvC0o32ynhrc+rvo/DhJCl3akSgCrkpUrVmFFcE9hCDr9qaw3UPqS7c5eVrbItDaSPOVOn3kEHFI7ZT5WzP2Bch41170PG0NaCP4Lu8p2dI2oVtCOymHsNe3cYy9nCEKjrDYuXTAU+5vrttOlDFzF3J7k/fq+mqxtL0bSI+mDyLxH+kGinVFkFXRCfmBX9tDF3UfTxhpQgX1tTs4pf37R93aVIMBIASEOkEx+N8iznpFb0owqF0gkqBoHAP7RHhXQqfaJ5WzGxn5UagU5jGAPUbq/HfZ4sT8VSs6j3OBRH80K43iTJG57LNc5SYm2xjRvOZmeAAyEOXyh9XLy13ozCwVxTegQwlvUhKyEmMA91eUkaxYLmOWPOWZlcit8jFFISNoYKZQmqRNNocRSsAOyjaKI8GkS6wFFEj5LIrtHSlNeNFdA9x0J6fyozMc82eY44fzQzl68iDZaIfRwOIJU6cJFOUi1xOQI9gi8Ow9yHADfQbEtr2hLl7icjXvgAiAO/FgMQEEyrty8NJtkwXnhhzFOV30Im1EoxMyhsGWPDWepW/zbsiv31FxCY0gqIWG5J6NYTlZ4QKffOLUJQhexlxKWw1Q78O/I2vt+q8rOI+xXphcN3sk8s/LAdo4/0RsP6JqQRtho9v3GZLjA2PRmlPAyOZ7aBciRMyTBUEckNRF08ZlOj+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(38100700002)(6506007)(2616005)(31696002)(83380400001)(6512007)(26005)(53546011)(66476007)(186003)(2906002)(4326008)(66946007)(5660300002)(36756003)(6486002)(31686004)(8676002)(54906003)(8936002)(66556008)(478600001)(41300700001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk5CQnlCUFJrSkhrSWFpaExyWVRHMFNENjh5OVFXTlBKU2xyK1NQOVRxZUhV?=
 =?utf-8?B?V2w1QWdPcmVQeDFhb2lOZE5BaUlxRE93WG9tU01QWEtpa3oxNnNvblRPU3R0?=
 =?utf-8?B?a1MzNUtld040TDBTK1hRd3ZlRHQxMFlwdTJZd25ocllqRnhnOU5VanEwM3d5?=
 =?utf-8?B?M3pNMEVZRjRidnBrOVVkUHk5aWZadkVpcy9pNDZMS3NSaUVnVVFFM0NQTTFa?=
 =?utf-8?B?VFVuZ3dSSjJuUVVITEI5RHRRVjFlZWdzb2RiQ0xIVEdndWE0anB2RVljemJI?=
 =?utf-8?B?cXZUWWxoblZZeXVmazI5SXJPQ3lMK0tnYldUcEY2dHVybGIrSmVIY3lMeEdW?=
 =?utf-8?B?K1dlUmdmUVJXWVdsZ2dtVHk5RnRUMVhnaDFhWG8wb2wxaFNZazM4TFBLMEtu?=
 =?utf-8?B?MlBxUGViZDlEeHFmekRIeW9lYXFVV3J0Ykl5c3pMR2c0L1RNU1dCUjB2c1VM?=
 =?utf-8?B?cmRJSVErZ2V4R0ptamFXV3IwRUdTb0owSGhuTXAxbU9UUUYra2RQTzlIa3Rj?=
 =?utf-8?B?TXFlWE54RFFCNG5RdDZ3OEJMbzl3bDVmTXhoVjVBUWFtbnA4bVluOFZVZElJ?=
 =?utf-8?B?bm1Fak1VR2h4THBldTRPTkVqZ1VqSTQyZERSM1UrMWlsejhiWW9hc3JaclJ1?=
 =?utf-8?B?eHZDczlWNVQyOU9XL2p4cGdqeTVOU0hXd0tMSUJhVDEwRG0rL21WSHFtQlZG?=
 =?utf-8?B?eEZLSmpDeWdMaGk0NS96TFNDV3NtMjZ6MGxnQW8yYStKVzluYzlvR3lLQisr?=
 =?utf-8?B?UzVlZkIydnNqNElHemVCQ1lPTW1rV01UdDRYY0xXZ2pTYnM2NGtrcy9vZnRM?=
 =?utf-8?B?ZmdpNzJ3OHllVDZ6Q0RUaUc3Zm90NGh1OWtTM1NpQlg3U2N1NmxHN3REelA5?=
 =?utf-8?B?d1JHekU3MWZJVDhSOGhrSUxlT2pJMm1EODBtTWVabzNGZENGcXRHeGlicTJB?=
 =?utf-8?B?Uy9Ody9GcDEvUWl5ZnArNFR4enllcmpOU1VOSm1lWmdLL3gwUVpsdmxTSm9o?=
 =?utf-8?B?QXlkbXlYdkRXcXNuQ3JxS0RJeHJJN3hVSHFKb0lQSkFPS3dGQWRRQk4xVHEw?=
 =?utf-8?B?ZFR3UHd1NWZ3a1dIcVlIeFUxUE1LbmtjWVdNVnExcVBWWVRNWHd1bVpsOW1s?=
 =?utf-8?B?UENZZ2Eybk9yVHNEZFJ1aExzRkZoWHRjNGN5WWFMQVJ4OVFXSVdDQzNnOW9F?=
 =?utf-8?B?bHBhQ2V6QmY5bkJzMGZNckQyTW5qdEM5L0k5cHlXdWZiRmtGOSsvV1BwNStI?=
 =?utf-8?B?cE1mQWJJZ3kyR2Iya2lONkJvSHBvUTh3NzY0RlFrbjdCd0llUzZ5OFRUbDZN?=
 =?utf-8?B?MkdzSjAyRUhaZStJdWx2NEhiSFcvTEQ2UG5kQTBFb1hBMkVtOENXVUJQSWJH?=
 =?utf-8?B?ZUlyaGcyTXplZGV6b0N0NCtVMEx6emo3MmZQdnhFeldBM2tCYnRuSUN1QXR2?=
 =?utf-8?B?d3FsY1lBbU96L2pmTU5ndFM1T2EzSTQzRUlSeVNoWW5ZYjRSV1FUR2VYSlF3?=
 =?utf-8?B?WkVsQzRJMU5sSGI2SkcwSll6N1ZzdWJRVURsZmpuZXRxS24wYUNsZHBNNjBq?=
 =?utf-8?B?NTRuaVNlMDJlOVJWN3Y5K0lDL3hLNk0vZVEyMVEyNHBpWmN4V1lBTUdYbmhl?=
 =?utf-8?B?OUoxSGZBUXlGL2RTdlpNMVlDbGtKRDFxSUtZaGZYeUl1Sm9tTXRvUWtjSlhv?=
 =?utf-8?B?dnh4SHdVV1hTQjgvV0NRVys2Rms3WWRSbUo2S0NsUW9kYzFTR3dKaU01eU1p?=
 =?utf-8?B?ODhHVlVLcnlpSUMzeHJPYUZzZFdBOXpSMUhPb3Ird2tLMCtTdklHRnR6RzE0?=
 =?utf-8?B?SVJ0YndnMVBvVG9FSFhDWERIQ011SHdISHpJMVFQOXVacXhEWlVndkcxNmxO?=
 =?utf-8?B?MnNwWHpmWGI4a3hUVmU0ZnJycGZsanFOSkZGL2xBYTcyK2JaRVVLUVBaS3dR?=
 =?utf-8?B?SEh4YXduNVUrL3Z4bHJyN1NjejliRkFqSGJtMnpRaFE2dkpLcFJORWprTVJ0?=
 =?utf-8?B?VjcyRnVGMGx0SURkMi9BYVllNlpabnFtcWcxTEN5L3NwSXdNaXlCMWUrazJC?=
 =?utf-8?B?L3gzZXJxQXE0MjBkZWl4NzM0N2thUXY3RHlqd2o4NEJhNWVQZ3hHU216MS9I?=
 =?utf-8?B?SlAzdkt3eHRzYzJzTm80N1RKSjBDN1Z6c3Z1SzNRNVpwZGhGc093WG9meVl3?=
 =?utf-8?B?LzMzL1RGM3lIQW1zT3YzSUVlM2RpbW5JUW1PeHdXRHBUMEJxbWkrZE9wL1kz?=
 =?utf-8?B?a1drOFFickM3aFdJdFNMUXRTMktoZjlkMlBmaU5GOFN1UjF4aWlvTEZ5Vmgr?=
 =?utf-8?B?Zm9rTHRoOVBqSkRscUN5OUZ3bVd5ZTQ2NHhCZ2tZOHhoVnFYZjFQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eac0c41-022f-4c10-aca1-08da53a62be4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 16:50:39.3991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqPf4dpo8ie9vurQXXQDgX7GWj7Id+e643VrWzLNnpGR61KjsSrx8suppTQfUCBc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3075
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
Cc: alex.sierra@amd.com, felix.kuehling@amd.com, Ruili Ji <ruiliji2@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-06-20 22:25, Ji, Ruili wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220621022550.492588-1-ruili.ji@amd.com">
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

Signed-off-by: Ruili Ji <a class="moz-txt-link-rfc2396E" href="mailto:ruiliji2@amd.com">&lt;ruiliji2@amd.com&gt;</a>
Change-Id: I97786f02849dd047703d6e8feff53916b307715c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1d0c9762ebfb..12fc822c0a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -739,7 +739,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 {
 	bool all_hub = false;
 
-	if (adev-&gt;family == AMDGPU_FAMILY_AI)
+	if (adev-&gt;family == AMDGPU_FAMILY_AI
+		|| adev-&gt;family == AMDGPU_FAMILY_RV)</pre>
    </blockquote>
    Indentation is incorrect, <br>
    <pre class="moz-quote-pre" wrap="">+	if (adev-&gt;family == AMDGPU_FAMILY_AI ||
+	    adev-&gt;family == AMDGPU_FAMILY_RV)

With this fixed, Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
</pre>
    <blockquote type="cite" cite="mid:20220621022550.492588-1-ruili.ji@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		all_hub = true;
 
 	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
</pre>
    </blockquote>
  </body>
</html>
