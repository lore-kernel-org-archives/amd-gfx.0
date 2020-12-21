Return-Path: <SRS0=mahE=FZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A166C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 05:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8C92250E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Dec 2020 05:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8C92250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9785D6E450;
	Mon, 21 Dec 2020 05:43:13 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4796E450
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Dec 2020 05:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afOBysgDv0NIDVZ1e+tRrT9fUtzN9J1mD/oUPz2REYMm48bK0IKvcY38i9AfnSOB8szoMkznavW+oqVhhoIDWE0ZlUiNDue2tTM5a5VaXNad/oeIOLp8yAMsQ7b+VtA6UUvotZCKKH9e6FX6GlVy/61XeBech04+NErnRlJnO61wLq2JwafqX7zqzjPFO8lIPuGB/y85TQOzNMhSF9zH15inl5JrbZDbQ/Vw2AnynYT4wTlOTWi3ucl/UmV4cCZjNeT98Qi78tS5fO4jDX+6AAOI7PQqvX3sz+lG6QMrkn58s8btODylmrwfKmv3HV2Mb+MKfKyrs+yDoa9P0ScIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5M2fTjpCbYHFg7jFZ/KfwkQENlu8rugPzufl4M9bgmM=;
 b=PZ43Wl22pShedSVRD9D7phqoIdepVnlkay2NhDOrhZa9fuS4RkokMb8i+emw/1NukYGF59eO+zGAGVyTTzs8Cbv4ZDhezONWTokj1OaxNM+kUyByD7VCMT3SXXZDugixSrt2ou5HFbPLJWtTRMMpasigCKfv1imRl1zFA80/6TR/XoSLI0gC7vGSlR/fHtVz/Z3AV+roN/gc+mfxO6ZFif8vWsE/nVYwyEgzn66HLwQVn5tTJ0BrIcXA6yr95i1l6yhL7FlFeWEarr+R52+TLXKaXQN5CKgDgRA4n/aFB7+rs+lFvj1SI9afXqJVXSAwtcK+WQfER0PjtC1k0AWeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5M2fTjpCbYHFg7jFZ/KfwkQENlu8rugPzufl4M9bgmM=;
 b=AdPAEv+jAiaGl2t4jpsMI1NNzBIBmRvKDrTTIAszFDclgscIf8ztlwNc/rkr/Y3fWAfvRgDw1lsY5yCv/U1JJbmYKj0ZUJ1Q6UTPkdGBEHAi1TrFFd4LCAcF6+h3Ga/GsxgysEPp2L5G3UjR3yx/UWG7rL8Q9caeQZU7hJoIggg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Mon, 21 Dec 2020 05:43:10 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 05:43:10 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Feifei Xu <Feifei.Xu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: enable software ih ring for vega20 ih block
Date: Mon, 21 Dec 2020 13:42:42 +0800
Message-Id: <20201221054244.7421-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (180.167.199.189) by
 HK2PR04CA0081.apcprd04.prod.outlook.com (2603:1096:202:15::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Mon, 21 Dec 2020 05:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b2497c5-39ed-4fe2-43f9-08d8a5734cd6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB298624AB5A9A54DE617FDC35FCC00@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0w2fMuJI0OcJ8IjCJclofEzJad5bnvD7zUJ79IRp6ClKqHQXC6kWbW6oEP84A3AW6vObI+R6ag6rkZs7qv8R6//z2EZ356Pbk/6Ce7cUfZarYW+994CSKEuhP2qmj4oXUxq7GB9lV8mNcS/hEppzqJC+VRuYbKDgoI0SbgqTvaXZ1ykuRNl8/Gue47wfk/3ilHxFQ1BQPSx4uGKqoa1VdOR9NwE8B9OGAWcxtFr2H5nnFwl6OiIEmlq3M6mjZQpABWMrOJoELufR0O2I/OLb/ki3mNwf526DtFzNaAgKim0HzKlLP0o+TKVfguiZETOodtQf/7pkkJ/Q2f0b/wZKolQzy2OLvU1MXUjb56JHPz4+MdSh1nOQoD9SLb9ndn7mXOAzarqkhHqtEb0MDAw4lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(2616005)(5660300002)(26005)(4326008)(6666004)(36756003)(4744005)(7696005)(1076003)(6636002)(2906002)(8676002)(8936002)(16526019)(110136005)(86362001)(6486002)(316002)(52116002)(66946007)(66476007)(956004)(478600001)(66556008)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dOH71k006PM5RZGnBqwDtSTretO9kczv6Eh/+ubZOyMIx8wlgqViS9E2cY5j?=
 =?us-ascii?Q?cLyGYPJhx3xZBsrmSY6p39Nfp/3T0X+HIIsGCGn63OFg2rPC/liN5NaEK5ZQ?=
 =?us-ascii?Q?oRTacGka3PWtrR8IR7m9ALtyDpa2XPPylPzGJv+NVSGTew+PXfrT/cUvq3pz?=
 =?us-ascii?Q?W2JoGagqnJVGTqAIcm573GuirpCqtYq2DJvKgYCoH2QLPalXS1x/2SJVZp8X?=
 =?us-ascii?Q?+eq0G9zv4636fHJfsRue9aks00prKPQvuTTIZEJxhvuXJBOP+TfFlbzkoCjg?=
 =?us-ascii?Q?BjSf01KkvrBNo/awfH4AneaD+39nbRhiGL0jBTttyI+SlixKB78EdDzdIJ1s?=
 =?us-ascii?Q?biYiBbnNN7TnT+Ja46Hy2XEa77T3MkXQdwgclB5zcOxCC8DuXDrgHL/vP9bZ?=
 =?us-ascii?Q?/I733fRW++hWPyIMesOBfR4kY+ulfMP5KO9b3diWBtmNEKO8rOihqR8PWTOC?=
 =?us-ascii?Q?zZjq2ZvWkD6PcVpCK9nTAAPmdZoZYjGZ6gOOtsh9mlgLRbYVG5kR3HCvCgig?=
 =?us-ascii?Q?meCFP1auhN28BDeETrmWtHDVkQkDzKbyQI74WBkKvOQ49uzukrPF3r4iXIHv?=
 =?us-ascii?Q?4NhRTPulscr5MJdcDn0ADscpRTsK8kg4C9ORZzIHl5xKtzp6Fq9yD+4H2UL8?=
 =?us-ascii?Q?d9z3w57UwKGLjh38Zeab/l7e2k7lfHyuqjLjwQoXGQFlOmClThgHsvAHDc+e?=
 =?us-ascii?Q?ez/FgXpyvshH0kaeaFunBj/Tm9XLXYHuxW/uRUCt0LXqvWRQZ6nOHz0QeJcF?=
 =?us-ascii?Q?MRVe/yyCGZzrjPjl4FmaYD1A0OZQlA6TNmrF6Lw7LaHy6+BEET+tA7e9b6eK?=
 =?us-ascii?Q?/ZeVr7rcDgWtRoa8B+Aqv6lpC2h8l+ozyIbodEhb2jFy4eBc65UnZen58VSa?=
 =?us-ascii?Q?rYnX1igGiEPqx9nh2rg5zR4kGB6WUhxU7DGrmuFF99DvOVZDF7WnPYuiDQAd?=
 =?us-ascii?Q?rDzBq/lL5YaESXDuLeLhi0DvIrviDPTxzRuuZtFgmgCcB6J41D3xH19+VsZ3?=
 =?us-ascii?Q?3gBC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2020 05:43:10.1041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2497c5-39ed-4fe2-43f9-08d8a5734cd6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVbamBPA3DNUDmgdLbtPBAAxdRxgPOtprcCHhbVWOFtS46ik93OGT+HAdUEIUc+u8U4X/wKICXpoq9pTZUqiEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

software ih ring will be used as a workaround
in case hardware ih ring 1 and ring 2 don't work

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 4c7bbd0b63c6..a1d4d67d5ee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -357,6 +357,9 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
+	if (adev->irq.ih_soft.ring_size)
+		adev->irq.ih_soft.enabled = true;
+
 	return 0;
 }
 
@@ -554,6 +557,10 @@ static int vega20_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega20_ih_init_register_offset(adev);
 
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_init(adev);
 
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
