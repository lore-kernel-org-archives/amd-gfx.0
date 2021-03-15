Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16241C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 16:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A155664EEB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 16:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A155664EEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6481889AEB;
	Mon, 15 Mar 2021 16:00:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057CC89AEB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 16:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHz8ba83p8uloXDpqr9itUzvdFRSuS5lCo7Ad6q07i93G8++szwDcA/M34E/E9PsMRMnx8VIS2eAPUTkzbpaPZt5OJhPaMuCmC4yKQYuPKVa//uvBpYIvayqcjhSi+IKsmkTAUWN8qIPIktj/2Mi8yJgt3Nk1neppR+dWDc9dIoPUbioJon1ersH8lXhYUlWx//lxvKT+c95zTluIUlOEZcRX13AKa4apqVgSbHwSZNYBMydBewb9FKZZyD4S5t8fb1fZQurVWhpaV/p+95GTFGdsnCiKcUKwEJOKp97LbFoqo97ywdqpk3WcR7F02VkMHI716KKG75O2lHvmx9Khg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJTS6aEJQ6VJDm2HaYF21fzgIeYQ3K6fpEfWemAm3cY=;
 b=FnuZsw+I9J6wKUXe5rbH9rNS1z3weOPKigDfPH1PRgXmRtStCoeiIbycR72SC1jJvd0NrGzOFGKRXz5CPyECd3XaruAgYXSYmU4+6ueQ4mQJMcSDWJmw8BacXVouFR60OF6yZwJdFOs2cgaf8vWvzggcAbXENMh+o8+YlQ2Myr3rzrDRBI+Gpkc/ZointIEbiP/eQY1KA5LE0JnMmxetYxW/WG8un5eeCFva0C3552BKkuzzQ7llnSG+fP70a64GwqEYjrCFMm7D3jqAZzrPbH+3Uoa7M2p6TJPRdxzApChrvPGBr+REVjlLmUaPuUcDq1H6S9p6vcBxIuxVbhSR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJTS6aEJQ6VJDm2HaYF21fzgIeYQ3K6fpEfWemAm3cY=;
 b=yX/7Oxz529EGS7EApopidAlZeuKshuJsYvookYuTFnUq4P20LQk29o3F1Zik+VUb7dz0dNpbcX1wn8SvS2wzVf7LUnF/eL2QsvAIPGNb/zWBa6Zw73dL3lzq8k0aDMS+GOkE6CjcntN5BnbYg/r3XEx0C5SN/gnTQzYeCE0uGyY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 16:00:48 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 16:00:48 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Keep pending_reset valid during smu reset the
 ASIC
Date: Mon, 15 Mar 2021 12:00:35 -0400
Message-Id: <20210315160035.27840-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 16:00:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b4a99fd-12b9-4149-c867-08d8e7cb7f82
X-MS-TrafficTypeDiagnostic: DM5PR12MB1340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1340602B5FFF25F4760E0A65F46C9@DM5PR12MB1340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCKodvHuMY7OOgpUPG94xUMDETAgY+yqcgiNkJJ1j7Zyg5q3BRkgcg13HjUiVOWeQVgcqP6FljHNpylz8KiCm5XLZks1pfamG71n+SYddtGIezy4aOKRPmocrbplYgbfDWA5YCL0Mh5tkVIdicWghn10LHylWKJhoDozgcjs1zzLoAZ4LOIUYobGW0XNJziJoT+HBnx0dlvxa++RC/BXaIEt2EuuMggTTbdWDiqWKsjXWGJhFZrUbUcJrZxmJme6qG1I5VPHzrQ49PEr/rkJdSEA0ekoB85jLjBHVGB7TvoW08gkRgwz0zPcKcCkc9hkWP9OSHqf4IqXOmXDBc84Rnfc6eJt3+b8ls+Ciw+DtKeEApUd5AdB9Mua9ayCj1dIDu7J+L5XAAL0iUHU1nppZnY9nL2Bs5FUQFHKa6GVH5cjVDYEi6GLA3/Q3FC/r9Dh28NsW3Ae+hypJvSyQAaAjKD5S8sB4muGBug6FcTv5vLMgkMGlkh7pLtEwEf+8lttDmAwApz0Ak8Af+y9xsJXxLe+bmxBebp0MG4ku/MlXXr0mfu5OOtyp/2GXr+eUa4tC1EX8PwHaTW44cNMjJuDtsLwVT/15jrTULr3cIMFuTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(16526019)(186003)(66946007)(2616005)(956004)(26005)(7696005)(52116002)(2906002)(66556008)(4326008)(36756003)(6666004)(83380400001)(8676002)(5660300002)(8936002)(478600001)(66476007)(4744005)(1076003)(86362001)(6486002)(316002)(6916009)(43062005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ULL1Hiji+myXPrY/tDN4ILdPQIcjd5PD0yJOo321PjkQCrzvl85QkcWgLuPF?=
 =?us-ascii?Q?bjet6dzXrnDIBkFLxfVvJo6KcWtrqiStD1YGu4e+aV7JuWtf2ytf4FtcpVug?=
 =?us-ascii?Q?cYxYlsn2NPZGFveUmHybTX5vZi906PpBaVfkquwootqFAPk9rVDuZhz4RcN/?=
 =?us-ascii?Q?1IXSpw66JUD5t+0OWGbKxK37nnf5FuabxcO8R/fQ9xF3KQ1ewgFH6ZTmaeEy?=
 =?us-ascii?Q?aMv1UhCui9mZ3X3vZBNscFWp1clwsPYeoasm8eItCISxre8yEZcHXw4m3+JQ?=
 =?us-ascii?Q?WJnSDKXz4QNKA1DMkGohYfEQyXb+PkL3vuBx1tto0gbCShPGwSU/zjmmgioy?=
 =?us-ascii?Q?2U6LNxPbO6x8iVEJUzbyJsLWL4y7/WfUyzBdVxiKyZlHPWwHs4IlSqGHcWui?=
 =?us-ascii?Q?iKTYOwrzdzfXEtJ/O8vF7xtHabs+JqavnhX3cnLk4EVgo1v3uUAwDpUYSu7e?=
 =?us-ascii?Q?dd2Nv6DpEYRASDqvgzLbShhKxd2ginhbZ6TNgI3XT2n37LgvFxUhMsV/3cpp?=
 =?us-ascii?Q?j3UA9OGIQnjM/9iEEjUG4ADdX88p3JplzJAFzm8QzCRLo0gfODCCJLJ+iI8v?=
 =?us-ascii?Q?LyeLg646lvvuRMcGp1rr2Rl3YAgSrfEJvdCg31dNA9qrzRlloO2P1GWxdxgQ?=
 =?us-ascii?Q?NcK/5KFw4cAJAVvE7x54d8Qm4KGBezCxSrxfl0fC8zNGO64udZeuRVe7vnlk?=
 =?us-ascii?Q?doKlvIn5gE55S5ZkMmDUR7aw+el+sGOz574oms1TV8OyDWPR8xmnlTZZKEtU?=
 =?us-ascii?Q?UfjQQkXbqZl8FgGCsDys7ux1EyXsEg/nlA3uxyhfIn0sKYK+7uyAcUT7u6W+?=
 =?us-ascii?Q?lIh0omIZgw8Ew0bj82MeOga59WncS876ZV8R+cd/ShhiARc2p/2pVi7cEf0f?=
 =?us-ascii?Q?Y6YEPvdSjAFtsMvLA2gRyGMcJj8ESzqZHdTyONcQD4ObzOLcDOQnAb6mDKV1?=
 =?us-ascii?Q?QUREwoCJaLN7qiUeZeVN9AdHh1zLYCEtMKpN99cWgZJfldrkJNZg7XKOQRsk?=
 =?us-ascii?Q?YZHr0+RBSkgO29aeaSLWBkSg8yXX/IjcFRW6Ks5zvk7rXqrnOsarFiE9C1te?=
 =?us-ascii?Q?BMURgepXomGVInPZRnF8XpDQRZ5r9X5NOQus1K7+xbtWmAQRv/MTrfF62mU4?=
 =?us-ascii?Q?qV9n+st/4miyMGGKVpufzWxx6ULE8RlZEFOsbIcfJdMLFUn9aziC7xdO/oIi?=
 =?us-ascii?Q?GTBTM9/zvpu6wJDGj4z0Dft89CmYAKgKHh9ugcaC/+hfOeKf73ZrM+03B9tM?=
 =?us-ascii?Q?790v/6q0WAF0sZXOJBU1t6eCjYLYBEqo9piQTC8LDk0+wSrV9d+MBkNabLpH?=
 =?us-ascii?Q?+RyBpRWeGLD7mf79eBjVAw8+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4a99fd-12b9-4149-c867-08d8e7cb7f82
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 16:00:47.8718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G84rCxXztoYrvB6mWV1/62NXkZjEXozIxBQq6hLmtRs8k1ZeUirOwNsr0gIEbzrna3DPTwISuqOM6Wkjh+NNog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1340
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU internal might need to check this pending_reset setting to decide the reset method

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I8d88abf56d481e7443ac31baa2929826aec9e576
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e0c4f70f96a4..7b3d9384b307 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1359,8 +1359,8 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 	}
 	for (i = 0; i < mgpu_info.num_dgpu; i++) {
 		adev = mgpu_info.gpu_ins[i].adev;
-		adev->gmc.xgmi.pending_reset = false;
 		flush_work(&adev->xgmi_reset_work);
+		adev->gmc.xgmi.pending_reset = false;
 	}
 
 	/* reset function will rebuild the xgmi hive info , clear it now */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
