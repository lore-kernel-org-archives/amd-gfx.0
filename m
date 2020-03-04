Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D9C3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EAF2146E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l9il21Hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EAF2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B1B6E065;
	Wed,  4 Mar 2020 16:23:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5696E065
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 16:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErCxHPqjg2Y333ijE7lt8Xx9d34UsOrWMOrUJN6N2nEVeTnm2CgUwbufVXB98vXUnEloXrLycqLTJ1PV6d+XqL1ioDaYiz6RxnZ7g9hx48FlHZKfo9e8ISUnutRMHQAfWMwtkF5ILANdIF0WyFgXCE7l1da7LGhldgToF92Wr5zMEFnqKycqMfMgv5ReUyMGUSoXnZMe5nSNBT1JWvgSOauQkCsxf2PEmy0xOCpKOZ0+OMNtftxiUv+j4oULKydg6EjK8d7OYbyyw0HPm3AB9kYtArTQalXKt3H2Nb2EUedw2M8DAnfIJgXGoLFjXq0CVCsp8w0FWdpd/rMUO5MGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfUNNg8YY4PGtCWwpqjVyANa6g7GnwQwa9fjVqF8jb8=;
 b=nhJEzwq+dSiij8DYG58NtDJ9mvjDMQCrSQ3W2nHc52kel1A7o9G2MtQLS7AVgBgUM4MHmQpVWTw0C8xNkFJWJ27L4YHa2tIpmuMekJN2MwUUaZexivgFYLNNge3vxFMGrPHYGmdKJmlHXvNvWL5DpcUONO2CpPrYcsmOFls0yZzEXjXKdabFkFooe/bIbqgXcjfEkXU3yiX3LcmKOfSXvOQRBPhKSz/eR22vjW1P3QSInfmIa5uW2x4uRM5s0/3RCvwFBEnWyO7U64hmpNCJj7NGVW4MslEu5oLhOZy7Pd6TXERDvjyKq8ThsC4xRiLD4LdGRQP1WHNZaVPDxs0N4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfUNNg8YY4PGtCWwpqjVyANa6g7GnwQwa9fjVqF8jb8=;
 b=l9il21HbEyejA7Wef1Fr8ySy/x+NHZDnvFKWdD8jUTwHG4LRt4F0P++PDGGzZpFBE8pQLovPH0z8ZWbBxlHaM6c/Mc35BdVSJiRtwND3q16dNJVZ6aN1I9F+EBd8oxvkMLUnkZhZiPm4nP6m3WnQrOmQHV4cLAQ9YV2SoOTTUyA=
Received: from MN2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:208:1b4::33)
 by DM5PR12MB1689.namprd12.prod.outlook.com (2603:10b6:4:3::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 16:23:44 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:1b4:cafe::7d) by MN2PR15CA0020.outlook.office365.com
 (2603:10b6:208:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Wed, 4 Mar 2020 16:23:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 16:23:43 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 10:23:43 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 10:23:43 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 0/3] Add support for USBC PD FW download
Date: Wed, 4 Mar 2020 11:23:38 -0500
Message-ID: <1583339021-12298-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(428003)(189003)(199004)(186003)(8676002)(478600001)(81166006)(8936002)(26005)(54906003)(336012)(44832011)(86362001)(4326008)(2616005)(6916009)(81156014)(316002)(2906002)(5660300002)(4744005)(356004)(6666004)(70206006)(36756003)(7696005)(426003)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1689; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985847b8-518d-4349-5091-08d7c0586878
X-MS-TrafficTypeDiagnostic: DM5PR12MB1689:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1689FF2F034DF53D31AE8C83EAE50@DM5PR12MB1689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYl7GtREf2egiUuL16zqUKe0amfT//nDTk8OmjP5yGBpJA7H3tUL5lXME6iaLHcDFcE1V65RQfDOWhwv/aw17fq74vxxZAOM3W+s9hUPnzRD859Xld8+fLbEJQNXyQmUCRfSELjmrdBKkt6xf4YTVlCaO3q1B7Li2GWAO1etuBLx7Q8dq+B9p6NVNqM/JNvwO95VR0E16RVvnBOQoyRIwf6V6jyWf7fTNOy1BMU0tmi8rWx1AZMqTaOYXKV+rqUhcdRFkCoX0kjlrOlyffeZTpK0cNGbmmMhf318xNRu1oFDgo9+q8UaZvWzQ+wQwGKwXmAJ0P+cD6h7vet8zQQ5PFxHNb4vlo3jS1yyu0dcW/Sas7o+KfhaPXoQXPdei17f0XiiJalH7sumHy+8s0hhprAt25a3AbsRqkr7M1Kgl1h2h5e07W8+AoVWbMgIj3vg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:23:43.8155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985847b8-518d-4349-5091-08d7c0586878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1689
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com, luben.tuikov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset adds the kernel driver part of supporting USBC power delivery
firmware downloading to USBC chip on the ASIC. The FW is placed in DMA buffer
visible to PSP which then proceeds and copies the FW over I2C to the USBC chip.


Andrey Grodzovsky (3):
  drm/amdgpu: Add USBC PD FW load interface to PSP.
  drm/amdgpu: Add USBC PD FW load to PSP 11
  drm/amdgpu: Add support for USBC PD FW download

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 110 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  10 +++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |   3 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  |  81 +++++++++++++++++++++++
 4 files changed, 203 insertions(+), 1 deletion(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
