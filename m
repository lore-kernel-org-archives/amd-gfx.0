Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F4DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 10:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B53521973
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 10:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B53521973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12FC891DB;
	Wed, 30 Dec 2020 10:02:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802AE891DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 10:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yfq063hxpP6yfiaMn0LMeDbGdiazIGEqzj9nQuVVWJRmV0SHZg02ED0/U4+nyM1EtcXn4GXRh/SpTbs7oJYpSN1auMjj+JlR7xaba0S5OiEd04aJ/qpxtHX3Hv68KSEIGBnRE6k2zVCam/yoSn+wauxcNWwdusKCj4e0yPXVqg6Ak++Un00vYC+KhRR6pK899lUoUKWswWuKOOefx+ZzRFJOJGdfPIppXF+IQ57CNurlXLBGR73QJcHFFqgdck5088pCYV493nsuSEo9bjkSpHbqbUpnEPrBcRjXVod275sYf03NLYTceDT8DIY+noxhWddCl5dSmSWF9tnS9hKt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iiENlVfAqUsK2OZTVbsoYaTBs+7AoBShlMWisxwp+k=;
 b=cqWVY67oenYyFkCyRubAY19GJ9DwjAiB1p2sPiRNEKp0KMc9r9gIqTtYNxYmlm4LIsVnu/KFpicBQ0h8MVonPBcV4bMk6CoRrSCo8VWIHf+W1sHWphMpMPQAoONFBbn67YQ9IDH+QsL0fem2T//II689LqCe3kJLFsdLgZ1v75t0kkr1uzEhN6tArvsQ4LdX8XbKHAQbQHV6gNPgcxPBLH2hZNedqlaMw8W9spmrHpSuAW3azGKi+zGWmjwAKZKx3nE69/BxTuzs6kd7Yu2bK3iEhS3pGSdb3YQFrHbANEWSgUZbAmpVhDZgw43S7uzkle4xfB7tqW8AO2pni7hdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iiENlVfAqUsK2OZTVbsoYaTBs+7AoBShlMWisxwp+k=;
 b=IE2ufwTnomuwKH7u6FbNBsjRBOQBj64X1BOzAZ6rUryrx3seNi3h+XWLlz0FplWOUsQ/UH2x9KDe6tzOlao0kcgH/yYDcilrwY0k2dit8T80mt5yLXwg0TviHxavOdqAexE5XNHszQR2358o9OqZAVpgrFJ+xx/pmBXyOzKbMXs=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.19; Wed, 30 Dec 2020 10:02:18 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 10:02:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct releasing the same sdma fw repeatedly
Thread-Topic: [PATCH] drm/amdgpu: correct releasing the same sdma fw repeatedly
Thread-Index: AQHW3o1m0P/zlEsJC0SmWXNg0G3PN6oPaBYQ
Date: Wed, 30 Dec 2020 10:02:18 +0000
Message-ID: <DM6PR12MB4075516C663A786B8BC04BF9FCD70@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201230092253.3137-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201230092253.3137-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-30T10:02:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3776f79f-fee7-43ab-8325-ee9aa6a105cd;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8da4819f-4ed2-4a72-b545-08d8aca9fde1
x-ms-traffictypediagnostic: DM6PR12MB4530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4530B26F5E4074EC716A9274FCD70@DM6PR12MB4530.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/9AAFtMov9upt8T22hGtsKWa42Ay2rmz+bT/AKzYzCbiv6UASFfAGuCaReMuFu824sswSwxETePpfgW6LsKJFSXAkZIMmPA+GJ7r7wJTAo7nA0jNcks1StpUv7q5EWST7D96wFA6YSYOQ8zQ9yhVBvAbsRI+ibgGu87Zw8O+8Es4QKgkGPiPJBT88vqLzgyl4QTZ+ooDGVjIt7vHszuw9jKjUJAnaW4i1431O3fx7zR3oDU/pSdvffKqG9SU8ltRytatKel1h7pUY9CT22/pfcbfnzcdqwWU7dmMV8X7ss0Lw+gT8MhpVCswZ00rBLVF5REHgBMK2HXDt81L+L9AqcBGCxnXM1tagXDv4ReqlXOfdZJv69+5a1KKhRSCVJkhq5zZwnibK8AVcoWsl8gSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(83380400001)(2906002)(5660300002)(186003)(316002)(86362001)(55016002)(66446008)(26005)(9686003)(52536014)(71200400001)(33656002)(478600001)(8936002)(64756008)(66476007)(6506007)(66556008)(110136005)(7696005)(53546011)(4326008)(54906003)(76116006)(8676002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KliVLOH32AsyqSvcpaVWiQtr48UTY2bxWgQn+xTe2D1alDGsmRJetbwdynhk?=
 =?us-ascii?Q?PFBLo3HOSCLXY0YbXLpRf+0X/J3hIk0L7pf1+nscnZEzBVj2cExFHj5q4iYX?=
 =?us-ascii?Q?Dj+gIfcemCGbGDDr9z44D4WmuLGI6S7lcJ50X52mIBadyVEvvwZFQNp+Ha7x?=
 =?us-ascii?Q?S5IYR5lXBPJUfsaQiI0dD42ac5CX216uJEMPK1LmM1sOEOlY8j8ccWLJde1o?=
 =?us-ascii?Q?lQdD42I4F9XM/hiRtzJXLxBDGmlNBMCvQk46LZ+SEta4Nq6yxyUYISyPLXzY?=
 =?us-ascii?Q?ovKBalLEqfvg1/Q+mcRHMwQRrDI7uI14Y71Z/uFzD7LbhpfjPh+SZ8R/BZmN?=
 =?us-ascii?Q?qxYnxboR+rP+Q5Q1Bla2KwHEbNrMM9kIjztQTcCRE6YGCK0dgesC8fxEEkW7?=
 =?us-ascii?Q?ncVXT3HjUlGs72i3GS8tlQGXG/dP8ntT8D2sFHNtJ3jsjDYNZ5c1/as4TAIq?=
 =?us-ascii?Q?lQ3LST2Xws2FVoLSpVyBb1gbn6XAbAQZdYAVUvYY6f+DaERTF7bGO52HHzYI?=
 =?us-ascii?Q?IHiFrKoh4J9Lveajsh8699vBkUFYXM7GeHMUaDtwRewxP2YF02IH07OoLOtb?=
 =?us-ascii?Q?8T5OQMzdAwXsBua0pC1AoI/OcSlv7XO0FxGnhb+H9RpR8wf9tE1B0c/zd+Ou?=
 =?us-ascii?Q?jvXv7UV9xOBny2hOMsViDJqWswhmZIy2zvngMS6f2KOuhGd4ZB88iHXwqy2u?=
 =?us-ascii?Q?WCAj1ITdu0S7OAlzNcFc255tZsKuXgi9IyQbZgWcqimcR9B9JwU1Db1YapF1?=
 =?us-ascii?Q?gzJ7Ih9OYkG03CDNkpUcO9r7MTz+wOmYYvOznmnuAEqsOQfy5SoNOZv2wgGg?=
 =?us-ascii?Q?mIgB9Iu8jRaxV3XVw9FcvfHVdQuUoSkZuP6ke9O3a1s+GhBSP7MwCR0LJTn9?=
 =?us-ascii?Q?RrdxEvDCaKvZOLuiJQr0gB/uKA+h6FMJDgYUoHJyAOeitsxHSv1bXwF8jghZ?=
 =?us-ascii?Q?o51iKZ9btqB9c4tqpB9vUH+0gW9gZCVsAvqk9hOTyZ4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da4819f-4ed2-4a72-b545-08d8aca9fde1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 10:02:18.1196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9ElbDA12E9g55xLtjIf0y+duaM+SqfSlwervkquoMJbSd6wLLkXfvhdx0ErMdWt7orsmWHpV1NltPYM74otSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Shall we ignore this patch and wait for your latest fixes that remove the asic type check for sdma_v5_2.

I agree with you that should be more reasonable approach.

Regards,
Hawking

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Wednesday, December 30, 2020 17:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: correct releasing the same sdma fw repeatedly

Same as sienna_cichlid, dimgrey_cavefish and navy_flounder reuse sdma0 fw for other instances, so free it only once.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I9dda4a9b73e20243ee48f54d8f0c7593d7e7354b
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f1ba36a094da..6ac314c8be32 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -125,7 +125,8 @@ static void sdma_v5_2_destroy_inst_ctx(struct amdgpu_device *adev)
 		release_firmware(adev->sdma.instance[i].fw);
 		adev->sdma.instance[i].fw = NULL;
 
-		if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+		    adev->asic_type <= CHIP_DIMGREY_CAVEFISH)
 			break;
 	}
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
