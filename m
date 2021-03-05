Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64028C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 05:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AC165005
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 05:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AC165005
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC8E6EAD1;
	Fri,  5 Mar 2021 05:35:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A7B6EAD1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 05:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTTnzpJJtxzDz8gAAKQKVCPCkinhKU7TCRDfpf5x8CR9IdJprClsrxM4TXK7ESoChqjH+cipNmTqmYLNu7ak1rwqAIOHVaGhpYNdkmaZ9Jz7g4DikClL6zE4NhzRWL5OVDz1DtNjpBuUIOiuFB6BISxzDGxTku6hZHSFGeFi+NdBJXN0XCMM/TuR/d5s4G3nUDE2f3AW+vjf4hllVeGZl02oiPxaWeZ22tCZwTJyXweoCDNGqkobar6+SB0qIqxIdYaE+B4zJI8e+/wX2eq28ujdC+G+Z0Id9zTJXkVqD1r4Dc18rStpCJGRdjUV44DAcVERII5tpeXcIOENxBmwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuaTSrhu5gHv3uNgZJSihPAUCfX1LgFas14jTlVWNfM=;
 b=fRM+9k7GRYmouRmSk4NRFeSOxbJZHppMsIAcUl6aBOdz/cPBvq9f6qiQh8Jzv2/SPikeYfPRbsA1c4Ct0rOOWktVtFN7b+9NU72V2sUVEcbYykgluDX8ev5hSi4qHhuvi/JwBT5d5ByMTHnpLT2CR15wGa5+JnbiHfGvpvRAIh0PKmwaQGx5YmxiqZ9kLIOnMkDCHZtVS8sLB3eceGPWDppEHo6PdBoQRXUNnJpdIlLxUVX3y18ObXSuZcf+wuoI2GXFpbWtVzeSuDw203mw61pQvke5WBBb9YynWQIfXUMaSPiA3xS0kFZ3qitOMCnocN8OL1bCbdD4UT6vKcWqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuaTSrhu5gHv3uNgZJSihPAUCfX1LgFas14jTlVWNfM=;
 b=dTt8yQ7zqHo1oH0tyhtOwqz4J/5859Iq6pgKJQj1Za9gKMIhULFVjIAugsdDdFOKBC28FShDtCUzIjfW2WYD7eXeN0vDGrfiHHKXq96axnk4nvfN0HslJq17UQpd/zsX0Lya5QI9WMP6XkGb3jbTXOKMueywPfbk92twSnN691Q=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Fri, 5 Mar
 2021 05:35:15 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.033; Fri, 5 Mar 2021
 05:35:15 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Topic: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Index: AQHXETJFMXdW8W4cP0aGwExcYJ2edqp037lw
Date: Fri, 5 Mar 2021 05:35:15 +0000
Message-ID: <MN2PR12MB4549D18EF741EAC54C46338C97969@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210304200851.4937-1-Anson.Jacob@amd.com>
In-Reply-To: <20210304200851.4937-1-Anson.Jacob@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-05T05:35:09Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b799a2c3-2349-4e4c-bb6a-5ebfc105de13;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.212.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0ae2be2-8530-4cae-fc57-08d8df9874a9
x-ms-traffictypediagnostic: MN2PR12MB4159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41596BA6348D25646D7F34A597969@MN2PR12MB4159.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: URPFaSVY6y4T3b0IbXBKe/pLNQWhXW5FnXzyNo2C8o4qWu57rVOAXdVbwLz44yDmsFO1/iL1gWW305UajJacLa0G29QxBeigqq2naWBkS1vhXlwMw0U94AZT2L8n5R/AACicCmTi4P03T6xgmT/a3AVjnxjepZ588vmTIhcSKlFLQJ2gPXHkQhwc4PDZmLEpcEj3wJGqud0HTjBJBgn+M5s1HClB19vaCIpKfRXSKhe/ZyHb73u/zzX5Zeui8hGJU4o4ILTEF0yELSdT27eBFFYzyTbd7n61PZek7bR4aT7haQHWYYr4nH8hC1HZ29VJvaXd/4Ai8FO2b0/MBK1vqUWpvLxIEktXk43v9/RywmkRt6Uifr2ZoJrxJpx6/B+8HUjyx9WTSrYNxXJamyO8qln3KGo9rR7fYXQsC78s5zotOx/C3b1+8eXToYzVFQmQNBqw/byvpsm4YNIOPV9NrGwbBbU/+xGMmkR2yqatV4mRudtJNInl6wbygV8zxHv4+tc8OMlfeXikuXUog6JwEGPCsVhtjZO32Ag2HBlA97EJwXi54/Bw+WGi0fLBsczu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(4326008)(86362001)(33656002)(7696005)(66946007)(53546011)(66556008)(66476007)(966005)(64756008)(52536014)(66446008)(186003)(76116006)(71200400001)(316002)(6506007)(8676002)(478600001)(5660300002)(45080400002)(55236004)(26005)(8936002)(83380400001)(2906002)(110136005)(54906003)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x6rSGYcj3yLMpkPiDHSWAVMV4xuggUHbR43etj6NZvYWu4qlcg9n7DaW8IZv?=
 =?us-ascii?Q?LzKq2Ydv7WxvQ0KDUbB39Xbqc2Lir6iruwiyF6SIhc5O8WO68+YXmEJUPXTx?=
 =?us-ascii?Q?BU2o925kACwks3Brx6uIkqqJk9yUEGYLSrqMc8p/aj+GgHqmO30skxiQ9T4y?=
 =?us-ascii?Q?+cF19rP/Diw3RKlV65sJZZ8jx8Z76rHdH4iVRhJif0qBdwryCNtmi9UlZHDy?=
 =?us-ascii?Q?QP4GFqc3BjHxzskBJU1R70EIW2D+gIoZRjouylsCmfgAXW7YJr3jIW27o01m?=
 =?us-ascii?Q?oJbN1TUK991PAsfU4fGkQ4nDQ/tShiJCKt8bHk6oaNNcgZ4fTPZxZiPVs/37?=
 =?us-ascii?Q?jWsQJLPxcm9oy9H0AYHm9rogPzbMDKW7aqqAXkya9ISWEyVqxHQnvq4LGqWm?=
 =?us-ascii?Q?Xzx/ztu22bVQHMln1kOe3KsQgo9iR5klW23wVvuOrbtDVuURNJSSTbc+dVg8?=
 =?us-ascii?Q?ln3IH40TcJifvhqmLo91+/Q9i1GUbi6mSA+006E4ZBJsKL/4GtN9o94cG8wk?=
 =?us-ascii?Q?2rCFzX9pIa0qg5o6k8Y3YFyLt8IBU5bneQ+LfEB+w1TFUgAaPF7MgBLgf+SQ?=
 =?us-ascii?Q?uYc91pqo/SK/qMKC/kb9YOXkFB2jMUsuT2KLxJlW5e8U6tMeTZzVYczWaC0H?=
 =?us-ascii?Q?KcY+qSusqPm1BQLPqma0xmRJlGE4lq162Tdywu2U2xA9cQjGwYm/1y3dTMGJ?=
 =?us-ascii?Q?i/my/zzWf0b3sRGOTPFKm/Vx5oREARRELGdues24DyLCVXP+dY8NWVESjmpv?=
 =?us-ascii?Q?+7778ekYh7D/2zKGYXKTnxQXznI3gpNBY6IoFtmvmmoNqlzwhMe4MBcXXmbz?=
 =?us-ascii?Q?zuXf/wLtjSCeGFCd9BJsFBbpvddDGQOMaAMxE4TIzwCn4NBqAWy26sLHzmK6?=
 =?us-ascii?Q?668uO9YLg7nUtG+IUUXgbMhx+qehIQRwSQ5yQutjhEwcD1IM0eT5YZPEdmLs?=
 =?us-ascii?Q?yYt548eJTcQ8TOwCCQRLmfND0ZSqHDmz0CcOvBa7iBH8ifWiQbujxjAvP8x4?=
 =?us-ascii?Q?2JJPpsdHp+qYC5ljwilgYZFmHEyFaaCXUJgsjcsHp8tWPGbT+Jc620DR6Exq?=
 =?us-ascii?Q?pzj736136Sl+zBBkxWCWj3IdxzyQAN7FydRwsZVOY2AnZz85KCvP0Vptr4cu?=
 =?us-ascii?Q?vW2pWEncw8wuLSUtLSeNwyaVERKE5MiThK+blwcnC2FGSYVI82MZnQgMhXM4?=
 =?us-ascii?Q?MJjemx5wtypaiZDXlQynXExsDUtJ6LKZCaUaPuvAhMxwndrBxOjxXLqbEigc?=
 =?us-ascii?Q?rF7vel7mouCEQqjYCr9scDFfnjUms3pSozjMbncnOfdEKqrA6IsCJThprBj7?=
 =?us-ascii?Q?wvSQ9IguwR6rL7fb+dJ+/5rd?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ae2be2-8530-4cae-fc57-08d8df9874a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 05:35:15.5816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhMM8pEJ8pa45P75fxLlr4lDV9JcruXkmyq7M0ZvybG0/wpSKVQzWHDZ2eOijSY9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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
Cc: "Jacob, Anson" <Anson.Jacob@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Jacob
Sent: Friday, March 5, 2021 1:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Jacob, Anson <Anson.Jacob@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning

If get_num_sdma_queues or get_num_xgmi_sdma_queues is 0, we end up doing a shift operation where the number of bits shifted equals number of bits in the operand. This behaviour is undefined.

Set num_sdma_queues or num_xgmi_sdma_queues to ULLONG_MAX, if the count is >= number of bits in the operand.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1472&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cc731ee10b10b4728138808d8df496648%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504853648181515%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=iNLxyPbJfbuUeKFA6ygwcBGDSRJcfgOGjMFNHwGzun0%3D&amp;reserved=0
Reported-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c37e9c4b1fb4..e7a3c496237f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1128,6 +1128,9 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 
 static int initialize_cpsch(struct device_queue_manager *dqm)  {
+	uint64_t num_sdma_queues;
+	uint64_t num_xgmi_sdma_queues;
+
 	pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
 
 	mutex_init(&dqm->lock_hidden);
@@ -1136,8 +1139,18 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	dqm->active_cp_queue_count = 0;
 	dqm->gws_queue_count = 0;
 	dqm->active_runlist = false;
-	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
-	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
+
+	num_sdma_queues = get_num_sdma_queues(dqm);
+	if (num_sdma_queues >= BITS_PER_TYPE(dqm->sdma_bitmap))

< > No assumption about bitmap size here

+		dqm->sdma_bitmap = ULLONG_MAX;

<> This assumes/fixes the max size. In that case why not make the earlier check also consistent?

+	else
+		dqm->sdma_bitmap = (BIT_ULL(num_sdma_queues) - 1);
+
+	num_xgmi_sdma_queues = get_num_xgmi_sdma_queues(dqm);
+	if (num_xgmi_sdma_queues >= BITS_PER_TYPE(dqm->xgmi_sdma_bitmap))
+		dqm->xgmi_sdma_bitmap = ULLONG_MAX;
+	else
+		dqm->xgmi_sdma_bitmap = (BIT_ULL(num_xgmi_sdma_queues) - 1);
 
 	INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
 
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cc731ee10b10b4728138808d8df496648%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504853648191471%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=EpuPBBf03EMa0S7rOqI8JieOmcT3GvsnsQMaYujGgeY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
