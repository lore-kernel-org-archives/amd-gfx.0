Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF0BC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FC964F3A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 17:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FC964F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F496EA54;
	Wed, 10 Mar 2021 17:55:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E006EA54
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 17:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jon7BM1ayFHU9P+ljUIj8d6lE5yt23Hr3qxs3Lfjdbxq4su4tz4zbE3BAb/RLcW7u8PMqcOOV5c7BkDgN4vA1nV2rvQWmx+u+I4iPPMCoT0KpKaG5j+h6uo290rtu94MQLnx6kTh+EV80XR6MyKG2/48GY27hHDAIBmgiHVAO+34y9uGBiZMoOvNgibKtnwAdugX+DDeyrC1xUjApk2WXw5pIefGPkHSEZFiTXErxFn50Hcvch0PzkVjryw7PkEVPRAaP3Yyz8Zrp1JxypgP6pEott8ulSHhbFiBhrSlTApiyR9OiBGfWoN7OeL+odMB2q5QSwh0ldH8Yb/XWdYxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFP7v74m7KShe0RYIvciAIRgoiOVy84WTMcbfRxTqnA=;
 b=UKqwLb5bPLk/jBdb8r3ZN3ZTI5/JqzcOzStPQSXsxscmj4wP5oEpDaD8ATwYa9L0/EUcc/ZFnCXRKdSf44zpQpqz7pz69c1v6Ah8+PALNDsB9GdcY5+7qAOtFyoqwTM1npW6Ni9enEWnAs1MXNxCNLZZTbit+RtgNoVE3v6RgrkMpI951cDVTPDsrWN1zvxHDLEfUVEXgCe9fi+dzIcD6iRaVn7DeA6Qqq3XfEKE+M1k7GqwzEhfz+AMyoV1jhO+6hAxSrPXdWGNy0BHzFU3i9FYE3Tqgd3zsBuMI9Ei1c1CXqfyfCEyg2fBz173FtezUfutzJazlr33Ipf46OhYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFP7v74m7KShe0RYIvciAIRgoiOVy84WTMcbfRxTqnA=;
 b=gWttig34I4UQsyh/IrsmLnPK9GEyxZ5vLKTwjDMT9qfTCg7ja/pUcmuImDg0CNVRE2cfay3jn2JFDPfMOnBe3h5totMkIgb9z1mqffUbjC1Q55/8s9gVUphuQjCVP7rIYvEnQ3NX5sCpyMGb0mDUDoD/5IavQ1h35/gDunk3hHI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 17:55:41 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 17:55:41 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Enable lightSBR for SMU on passthrough and
 XGMI configuration
Date: Wed, 10 Mar 2021 12:55:30 -0500
Message-Id: <20210310175530.9810-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Wed, 10 Mar 2021 17:55:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db326d4f-d511-4e99-93a6-08d8e3edb85f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB249053D9F212FC3FE89ADD8FF4919@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuTPpQjBGkRRRj1P0XKwrZmndRtkxHS84DXPvvAc9nRj6F5fC/AHtPTRz0YP7gTOdnpdgTYsC17+r6KAuOUbjsUNx1CiH78CI5vq6BD26pnOTTJgHHQIHCbn2EaSXypI5fThEyjLsBH7Dq9g6YLQHmntpJEnDAmJMjrsaXXQEewsut2Hy6If7TNDoNG+JmZC3Pu5PAPyk/R9jKm47C8NLBmiWOrwj5txm95RSlrjCuwdBYyVkdzb7j/iJ+Yb6VonhUOyn/ZgLH/jUVcRhft0CLhu5FYnNC+Dmni9iEKley56+/fWgGZa4aeO7GiCA9Vex4j5jylJIfkLAVIFLrTVBE43eqGQwnE08SJme6gmNJ6sAYSpspBTsYaelZLXv3cxjyZOVYF+cwdCy+Q8AutMDE7gOWeLBsS/bB60ebfXPIiMTAaNmQDCFmSgvIGGiQ3Ml4QBTNEF/BsCjiIY6e9eA36s5av/9oxkGHY6kKQLfspLm/Yf1KK3jydUzwMafbngorHkHfx1vLMXoxTy7G33vSzGqcZZFuOFLn6SiAxUBINYWfyb5Mnb2bMVJTdhRGFB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(16526019)(478600001)(6666004)(83380400001)(26005)(6916009)(66556008)(186003)(86362001)(36756003)(66476007)(5660300002)(52116002)(956004)(1076003)(2906002)(7696005)(2616005)(8676002)(316002)(6486002)(66946007)(4326008)(8936002)(43062005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wvvB+6v6Lsv9BcSqvbOcUZ1uhi/2mUfeOYVKDyEytal7ZiXRMv9lF3PM9XtX?=
 =?us-ascii?Q?8dQJcNSK2oopOmjtfxZLvsmZyHU6iQcBi/CNwXUDKqHxQqWxPWW+IJqsJjXQ?=
 =?us-ascii?Q?scmCatlenzvmn4zgeN2iGraOrhCltVCpq8y5SVWTEVVRCbKNtDyTwKEQ/fzJ?=
 =?us-ascii?Q?LxHoT36f9FnJExoBs1AgD7ZyDHG1Y0Te9cJBTvK04p3ClxyxI3WzpIMXPkwJ?=
 =?us-ascii?Q?JwsWCVhoGqCpTcnVg4KJozkYMhZmgOpgi4rBFVLV62qTLTbdLVqKDxODaTxL?=
 =?us-ascii?Q?IgbJacxIIpvcuJuHXRLqJ5g7wGe6EAUA2W+JCNvro+4BZXpmzBrUKDKnafrd?=
 =?us-ascii?Q?Mn4VNv+sps56vDCKVvdczRbfWnLWgKqBXE/H4qgE/mUAIPZ1DL5nXnyNpe0H?=
 =?us-ascii?Q?L/J9bSifqM2LxRzXu0CtNGEuk+2Z2UIw5z7WrbTcMj3ka09Ov0Srfe41BPev?=
 =?us-ascii?Q?8sxwJUfBqkq3eLxVJ4ar/JWMQPj4mW5gWHs4OL0EZ8sgDHaEsaFl571nM6Zp?=
 =?us-ascii?Q?wXSHQNriYmqJtTfaBE4BiHFLQJUHe9qJ48ExDxy31s6t0k4K+xOE0NK5nPug?=
 =?us-ascii?Q?0S8cL/EUuVrDtp2NzLktUGM4dNZLkXKHoPVhve1gQefQp7DXIaI6qcUaAIHF?=
 =?us-ascii?Q?PuD5Cy8j9lS/NqGndJVsCzCedsuNRH/PayEUAmbe4QY40gXg8JBT/19qL/eY?=
 =?us-ascii?Q?jW+efMz4arEqMvnFk2RcATesh56UQfT9MRZxRpwK7G6708mbPgt6+K3lD4nu?=
 =?us-ascii?Q?Zr7hoKjhwn0Nh10niHRiDMOBAt2qM3xh5Dwle78RxwexHBqP4R3o0rLe3CQi?=
 =?us-ascii?Q?qvpuq27bocfLlRGUMgYJlZRDQtCKgcm57TJr58W2JuoXGC+0YTlpucG9T8lU?=
 =?us-ascii?Q?zXh5H+MnsFMpOxRHq1CxKx+uxFTmH4QWKeLj/6iC04mSp5rqd3/dZYJ+8SUi?=
 =?us-ascii?Q?d0KvIuF+8CN+qrYeawwOsVLocaL5qBQVzXdL37FWxlJGqhO4c349FL7cqQEi?=
 =?us-ascii?Q?eH3VoG/51cWtlIc3Gt8gYXfSZbctYSkf7/haO8mUB1pr6SeIJ+5XVrToIisp?=
 =?us-ascii?Q?Rdad6d5jhM+JYPAEzY42wnTiDg82cO2vJDBu0okTb74MPtNmVUEIWexXzs5z?=
 =?us-ascii?Q?3x01+s37ba7tmaKqLBpkRsuIQXuWXxPhcJIwQve6qJA26GBidMw8XfOpiAny?=
 =?us-ascii?Q?FD5rLEqG+M7lH6F90rhxAmd9xEw/n24cgWGClD8amzjYmkktpIRJQSfh99xd?=
 =?us-ascii?Q?UWHiQzqJUxn6rq692yQaIEbWFpgymRvE25JVc/W1J4Fmo/O7Fm/psQt+zwEx?=
 =?us-ascii?Q?Gi4cpD6b//tDcWmCw/+8iErA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db326d4f-d511-4e99-93a6-08d8e3edb85f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 17:55:41.5189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIVHEFRkmZqM3CQhersl7hj5opfNacUgLZmKo/eoWn05a6guu7Vqs4ipYY3/8JJezmuOdG4fLHLazOqSUaMVQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
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

SMU introduce the new interface to enable lightSBR mode, driver enable it
on passthrough + XGMI configuration

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I59aef0559aba418b764e7cf716b0d98aca14fec5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4640cafae619..31a1783f211a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3630,6 +3630,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	/* Enable lightSBR on SMU in passthrough + xgmi configuration */
+	if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes > 1)
+		smu_set_lightSBR(&adev->smu, true);
+
 	if (adev->gmc.xgmi.pending_reset)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
