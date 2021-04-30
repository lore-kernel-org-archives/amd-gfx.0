Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC3C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 20:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D937F61409
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 20:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D937F61409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899806E483;
	Fri, 30 Apr 2021 20:51:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639036E483
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 20:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhLu0QIHYNjzSHrREzcojm3IqacD3ni03x8RS4Zip1njgowWzyWnB5tjBdkiFS7zLNKdQTwWAr/kaWh0/GMFFlXx6cQ7T3qjFgMrPkfLSXoqnd7hQHJB2kAf87Ppq1G3U/zibablH7RAJTDAtTzbIZJSwu1ALnUbV4AZaGd7v6p0qEZxNYKTrORIJPRam4oeH9YoE6EvcmNdsfcapKPB/yTCxZPPPcxeYHrMw95wzynxGED9WNhN2+d+YoM1NxVCHZPxsVEoPAStlKGKdou6btaGFK43EY4ykG2Xf9APnRZAITcuVZHRwvqN9AzuHFTBazS50mdGygvmbE3Z9VqLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMZVhqR4zhhW07wf/u+MBrgCiXnfNMG0kbumqaJjbZg=;
 b=FkIQ0vY4Hx1QJC3gzu3kqBI+q7CpfaiooQyxKNWtFfuDpOvTj81uAQ8eqC5kFh08jknMPJlnFQAD7QZbOLMTy0IMzjfTzURwK4CTCh4TytROZmNcb1MqGr4c89I1gHD4uKPoL2GS+vpKjERoJkR8e855foMs0Y/0y3I2QfmHlt7OCpZXcAunxO7bp+6T0P16fdT+/M5ihRrxWfZn/tdb/5MsmdcLNJzMJ/ffqtebbB899HRWrB4mjnhjt6hfevFlKemoH3hdOURGgl5eID63Gar32yJrKj7OcNlXOfA2VDZ7h+eAbACQ1Cp9QX48dchJ7QYEJ3vcpBn3AequUBMzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMZVhqR4zhhW07wf/u+MBrgCiXnfNMG0kbumqaJjbZg=;
 b=jloI5Elt4l+BpbqNBkz+CPfPTsnTjQmE8DeAGdLg0ON3ot//uufPjLX6eHH/jHbLBNth2j2wWCLWYkkjJ3hp00V1GRibMP6Q35bM1D4vd/JkRDkYzJ1z7q0nZFOJBLq5zf0t0Dw1KWgh13JCIpCJym1MF4XtOxi0ALYtkMHrdoc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25; Fri, 30 Apr 2021 20:51:24 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58%3]) with mapi id 15.20.4065.030; Fri, 30 Apr 2021
 20:51:24 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix incorrect condition check for pci atomics gpu
 flags
Date: Fri, 30 Apr 2021 16:51:11 -0400
Message-Id: <20210430205111.72778-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Fri, 30 Apr 2021 20:51:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d716803-195f-4924-486f-08d90c19b781
X-MS-TrafficTypeDiagnostic: DM6PR12MB2794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2794E624E0A12ED4E5EE7E85855E9@DM6PR12MB2794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cw/EQz65KiG19I39xw4Cgi1cO90YRZDD5yZzcGwSqsOC5KOWHiXGgSonNj2fPw2lMa+PdGX80EuHxY9c59b0e7XCfeaLsRsymfu5dYvFYa8thipcY2vcse5XZZzhqUhqF/LwTOYFircrx/8Ev9q6m1KAHaAPjaOXxvU3X8s4FuJPoqZhux9KVlL75NGE4SW5XqNeSbuiaxyY64vYhydlWwMYe6EyPEMXD3+3AWUYGnoTjvaHjswo3TcIeo1TL1nge8tcK+JArwRhgnR1oFJMJSOkaCQ11SuOBNflnSIVVmoCApE5aGuLFWiAYrpx5RyKrE3eE+5f8tDY9bW4f2n8cNYJ9LjvId9uIznImf4baqwq0TczyuzrKmeZ1t2SwKACUwT2TbxPhZUFdOsZhudOHWFKp6tAhmf3XXoHs6Yyb1JH/Yrji4s3OWkXuwdlrj5ppMY4Ai4W+LPn1J6aRY8GN8o+YFEm7kvQcMM0i5WCLV/HiH3leZ+BR74KziVm+Uv1ifNseSmIJ2Skh5oOPc4+wXaCt1avBukFLV3HZDOtPDPBk9Kn7ePPlxvUnvt7Jthv5Dv1EoKPHpnODM5jFTbLdBJgV2U++g6AxlkPh9amwgy2PodxnrNtyw9eb6Zbl+s/lJnJ8ovNnaV0GTjLhW2CNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(44832011)(6666004)(8936002)(956004)(52116002)(6486002)(7696005)(26005)(66556008)(4326008)(66946007)(86362001)(16526019)(83380400001)(38100700002)(316002)(66476007)(6916009)(2616005)(8676002)(186003)(36756003)(5660300002)(1076003)(38350700002)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?m8OExllg+f1NXfRmWfF7cL8L/lAnqqI2X6TDL3ZhWZ+LR8wdLGbsuBBhaC1p?=
 =?us-ascii?Q?GIBl2rgFpW7cbnpff0JMzh1AJSD1wSVKul7mXyqIiT9UGHfrQ/8d3Fvevumx?=
 =?us-ascii?Q?nSX6k/At9+OwQoyZ+v8ZY6youhjZBP/Mm7nE7NxNxxLiYDtQP3ZGFF7FRJcu?=
 =?us-ascii?Q?mC1fKWgJUJzcdr7oD+u0D27EUMB2yjMspMaJd4oVwd5Xni7Rc2j8vFKZW305?=
 =?us-ascii?Q?OqbG2nkxb02c02wW9OylCcCN3GzFxVut6UFLJtNJpAqnPyFVXa5lZ0xMoLFM?=
 =?us-ascii?Q?D5U6ThVIWBBvS1VUtmGNgIDa6RiuHh05O+wasOpEMBBzht3UP8VKAeG7HTyb?=
 =?us-ascii?Q?qjB3fhtb+prDqsBf8fO+FMDQ91bpBfG6aVqOtTFKKqP+xykkQ+qq8FkFzKj7?=
 =?us-ascii?Q?zb1PyaBWULce4oALixknJWLSo/+HgCvIopqLN3eHcBMltn8gGAdBJ+9Plwaw?=
 =?us-ascii?Q?07pWO9dPg4d5AH5C/OeKMX3mVUt/W4eUiZbiuzVUATXxWw6kxhfEYK5ZDhZH?=
 =?us-ascii?Q?/ZWfLmidvTILLh4Af2wxGs7M/8tht2YA/FhNnFXQ5ohXGt/2Zpa0hq+JuiTF?=
 =?us-ascii?Q?bcR2Ej0/QDyWI5j5cjsogDC2XhNgGR2zAnBIrRCQrUo+lsuVDtB5E6ojDk+f?=
 =?us-ascii?Q?RBknnXZhK+ZJw4mgVMm2F8XhqHuqi8F1HvGhwl5nh25X1fyReVtdL/peG9t7?=
 =?us-ascii?Q?XF5poPJDp9w7LPs3RCOBt+flwPvUBMFlqZvzEDxL/GVQnOCvH0jImrNJmlBM?=
 =?us-ascii?Q?jyxtupsbuXzMOjo3+FMZRB3erBQktq8r/GQw7B1Qx3kpYS6S+Iu+cxu7Aui0?=
 =?us-ascii?Q?xair63yplbXUElD935l7gVrNtkGAHdsFmHZvFIlJu8AzqX+g2MGkOyIi3HhK?=
 =?us-ascii?Q?SJykJNbimMT6bn9Ca7DGWIBlob0EuB3d4WpyQUI+5W503K9rehkW5pUOPvR8?=
 =?us-ascii?Q?5VRBz2q4Kkqp+ycfc4fdq26KzgldzID8hjK6EwOfTQ8S9j7Rb8EeazVPY0Zg?=
 =?us-ascii?Q?hBwfmZkX0TJrpoUkfygbw597PopzdmzJCrieaYcl07Vvj+H6YiJVq2ymSz9p?=
 =?us-ascii?Q?wRHR5gOqgzJzGsLDbUU47lUDMxv4oCtIx3wnN71kWctqnksgEvZIIM4Dthse?=
 =?us-ascii?Q?fRrjyUTkQv/jZuesUaG1YXKHXetTKdCYxKhATafBf7Bl03Ug8f7ldXhwJg4Z?=
 =?us-ascii?Q?unixyJLycJvGImoyQNO4tqb00374y1qZOA/JcRaqfI753qUqEcOdCReGxL8o?=
 =?us-ascii?Q?iZdIW01Wsvlyb7REcx89HXfijroA+TzE7sDQZ5K4HxiUMQGbGu7ja6JlhSMk?=
 =?us-ascii?Q?MXwWevKTwTneQMIe0Aw9bUqz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d716803-195f-4924-486f-08d90c19b781
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 20:51:24.3563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r532luJ/LbctwVEtLhzlCJF7xDWdoP77C8sWQeepSPYvdgqDNVpVB2xo/EGuxzKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Oak.Zeng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As pci_atomics_device_to_root check is a host to device support check,
the device xgmi hive setup status is irrelevant to setting the NO_ATOMICS
gpu flags so move it under the correct host-device check condition.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 30430aefcfc7..c84db6441c4e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1206,23 +1206,21 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 
 	adev = (struct amdgpu_device *)(dev->gpu->kgd);
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		pcie_capability_read_dword(dev->gpu->pdev,
 				PCI_EXP_DEVCAP2, &cap);
 
 		if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
 			     PCI_EXP_DEVCAP2_ATOMIC_COMP64)))
 			cpu_flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
 				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
-	}
 
-	if (!adev->gmc.xgmi.num_physical_nodes) {
 		if (!dev->gpu->pci_atomic_requested ||
 				dev->gpu->device_info->asic_family ==
 							CHIP_HAWAII)
 			flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
 				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
 	}
 
 	/* GPU only creates direct links so apply flags setting to all */
 	list_for_each_entry(link, &dev->io_link_props, list) {
 		link->flags = flag;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
