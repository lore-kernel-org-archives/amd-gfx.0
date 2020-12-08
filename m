Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F5AC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD68C23A80
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD68C23A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6FB6E0CD;
	Tue,  8 Dec 2020 08:28:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 785956E94E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 08:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNVz11VnqXgf+qPzxM5Lltg5AGNZU0BizayqBs744SDP39DnuGPqqP8r+ye7afzu0FM0fffBAO6rUKHukFU3dHD4POdQyWlCExGr/uZsTaqoBPDaq+LSJFUMf64E3Yf0uCRDHLgHCEobNmg/wfTbGufWSCZp3CHHkz1l2iHOkGlFCRXQyeT9SPI4zw3fbgNQBmNeHzASOSkvDNbE0AlY6eQ7cRlySwUmpAPvcbDz/wxqUVm0H/DZSwiK83P8KWcN43YQ4XFJJ7Z5VrtJTxgBoks3gs//blcc25kmYAGxrbsZh78Fo3YRQfElYPfAAnUWSDpfUn573TAXLtLLM7y7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRESgfVO5V8MXTp5tB0ccugsktWjV5rIe3+xwwNgFi0=;
 b=QTecDbqv6woAQZJaXnOMV8Xo2Bjp6foQPlqSzhdfmPiLsjFxI6qpSxQW0017tiX2CEjGbXsRARpjxYsOin7ykb0uy2x6wrbBYF+q3L/NrkHp1mEn3DVGZqblRrFTE+DKmWdLce2nHsEfKtQzt0LXcK5K4kCHCGiIqq2HLzlNhO/9O95Ems3/DjCQcMZUHTr5OzLnCs4NDs5RzkXPruHIF/I4/7wUf7ZiHAXqq/jJNIoCWJgBrRX+Lx1fhS6BCENIr/JRJKRCD9QmjYDxV0ArYY6geGZHWQBpLpx82bJyh8Do+m91H12WuBpTOSeSmtqttW1Lncu71wlkHoVLrfmBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRESgfVO5V8MXTp5tB0ccugsktWjV5rIe3+xwwNgFi0=;
 b=Qzx4iD7UN3TSko8iL5ZK4Ec6gzRJqMvyEhpGcU0gPSR170gHfdc40MyMwx3obrWkwk5Ytv3XJOOluGG+MC6+2oura8wMOpygiSB2N8HfrE5UAtG1noCTHiLY1+reRdNBMtnX12ysVSwH228j1u0pbbqIHV0mx3j5t3kzvnMO6SQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Tue, 8 Dec 2020 08:28:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 08:28:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu: new macro for determining 2ND_USB20PORT
 support
Date: Tue,  8 Dec 2020 16:27:30 +0800
Message-Id: <20201208082733.126647-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201208082733.126647-1-evan.quan@amd.com>
References: <20201208082733.126647-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0061.apcprd03.prod.outlook.com (2603:1096:202:17::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 08:28:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 996e26e5-cc9a-4922-55ab-08d89b532d5c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2507A4E2532BE089388FC832E4CD0@DM5PR1201MB2507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S024IVP5wdEuuZJsF1Ekx3VJxXffjH34M33WdXx36MVXwCktDIArlio8lcc7ooghmq4tDLjoEugd5CQAsLqMN6u94ELRPxjNgs5/Oqh+EEBehPkhhIhD9VrTYlyzt4ZwWw+TLNYHYAa0q82ejrZ8zDJrqd+Iy2x5b5I+P6ZMh2kUCtSkesq2R7Em5o1nq/mSJCTTPcPiTyOyHE9c2d0nQNopo5JOQjYFolAPbKYt4nI7nNnrvADy7Rsg/GZrjriq80yVB4dfN3Wko76CvzwnsnbpShgQZWBVofn46wk7awj/XsXOhHdU55gDdsR39yCW+Eyg9Z/NCAWJeeS0Np30cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(2906002)(4744005)(4326008)(8676002)(52116002)(66476007)(66556008)(7696005)(66946007)(2616005)(478600001)(316002)(8936002)(26005)(44832011)(956004)(186003)(36756003)(6666004)(16526019)(5660300002)(6916009)(6486002)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dDjpywuRdbEhGUZu7i2iHRfHWHmKUIHnUm8Gni4QZkBT0oOf7xXCzdScSszE?=
 =?us-ascii?Q?NQGSDq3oZRVHlXagW0GRDwje+a6jiuIleXaqDQ4AhMqHMLvOrzZAkEQfh3cP?=
 =?us-ascii?Q?rick0gjOgdMTdrM79nGdlnRQc68XELVOAH4AOUtI5bk0ecg0OMS6vrzhAj1y?=
 =?us-ascii?Q?G3iAGG0ygjW99yl4Qzi28ylsJ703br+FHJVnuSaTMO+tBdggRlx562uaCnU4?=
 =?us-ascii?Q?7ZNmGhKh64t6noD6g5Hiy291ZT6dFOY8RBW8mtAE0lKrW0mplxZPciFrtr5I?=
 =?us-ascii?Q?CIdldLeUPTpBsT67rG3CTuexSSV58on/MtKAROb+n5pPDdZiK8nQ5mMQ646g?=
 =?us-ascii?Q?m+/rOmgz7k2fhnMd+B2299fjCizT1qQCDBlLH/DVAFIRcYIG/AMsQEnde1Dn?=
 =?us-ascii?Q?xV1mr9nPAEGKI6DIdIi0yqpac020LuH/ZWDUU04KD2sfP9WebFqS5lFgvuLX?=
 =?us-ascii?Q?Aoe/KeYQpMc2RhhRvTAp5Qm2XRHIatJc1S/DWI52oZ6w9+dIDTU+qO94Rg8a?=
 =?us-ascii?Q?ypk04aZq9uslF5etiHi4wDkVMD9+nJe0uVSFPecuSwHf4KDTACZoIXRWSyJ3?=
 =?us-ascii?Q?Jn3+J6gisJFemxheYhVJVds1rIcNM0wGCTW96lHbvLHoafO86JO47XR4LeL7?=
 =?us-ascii?Q?lGjRCm+RwB5OniWGjwrApBMmtF5CzbonUaJ5ftP2bXb14aN1JTMO2vBmI7jw?=
 =?us-ascii?Q?x03u8pzfd4lMQrPdF6hhxCp6HLXY/r3DA7Rgtnhy30p8Iu/qrp1aUDgzn6Go?=
 =?us-ascii?Q?7Ngk+BBj+ihyFQhmVuwOqicaLdw5BvxRNv2Kuu/0Gf1fYAyFrURpUeWgIHjl?=
 =?us-ascii?Q?s4U3hvhExaZSu6ROszOPWDYq7QYIAH0apqyDisIbJ2wMNpHMWe6kVBGcsoDu?=
 =?us-ascii?Q?h/XNx39qLvPgQK3WZuGH2vkisPDIC6hSGbUoi+wJPgTvWr1UWiUd5tp/yC5h?=
 =?us-ascii?Q?maLgmk435psXLOoLhE6ROj2/s8CHY9+8kEsCjW+JfbbxTWfOgu6N5+Q7N0mW?=
 =?us-ascii?Q?o16l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 08:28:01.7762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 996e26e5-cc9a-4922-55ab-08d89b532d5c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR42rrysAKpPY9g+nU/PT6QY9hh6ghWAuRMf/uS0bPtpYsd5POAVDBij2E9hvtDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used for determining 2ND_USB20PORT support from firmware_capability.

Change-Id: I3ff37f0a0dab311566bdd0aba189f2b7fa89ec2c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index c38635992101..3cb8d4c5c1a3 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -499,6 +499,7 @@ enum atombios_firmware_capability
 	ATOM_FIRMWARE_CAP_HWEMU_UMC_CFG = 0x00000100,
 	ATOM_FIRMWARE_CAP_SRAM_ECC      = 0x00000200,
 	ATOM_FIRMWARE_CAP_ENABLE_2STAGE_BIST_TRAINING  = 0x00000400,
+	ATOM_FIRMWARE_CAP_ENABLE_2ND_USB20PORT = 0x0008000,
 };
 
 enum atom_cooling_solution_id{
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
