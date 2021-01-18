Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80527C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B80A20759
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B80A20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B358489C0A;
	Mon, 18 Jan 2021 01:12:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E451389C0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 01:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya7VcicirMsDJxVbX/LBSyyjRcpRrH6bPMVw0CKq3Kmv2GNZjceO8lz0T6nvpl8q8VDqlvYJ7I4owFGrf03R9tNSp9sssXr/30atugeEVHurzATpcL/EPDP3Z1MCPQKQUPsCGqfFv0hulF9CI80y1h5AnJnjj5pgavR6cuICdgTkRRoix8pNIwnG2HLWZSMf5Iq1TqZznvgx9xiD4/GoXxhOpqYjUQlX8YaK76c+NC7qgF2XyyDILn0cAOVV4jLT8UrSDBC4HgdzPret1lN+IKUI1lj6mm2Mu1aA5Zq2sGd9J70iqptarZIjKHR25E3rITu/iZRY9AgVSJn3bpXwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T15FCJrb5Xg9uovCcGEdfv6iJnqpAghinZJ4b4uvf/8=;
 b=gwMSMDPSzhVTXpVkSdyAa4r8gwajV79PBwJck0+m4bDvrGzm4xbKGK+VWlO8kxSwxIR7XYJU05rVzMKAP4rGuH0zJCRNI4UI1R/2y2K+vcWHlSdVn2NISe3LnzD+WtPQRPM3mzNPnP/PtSFEiXYJRDNrnfW5eD77dWGm84r+emuHuGUNfx5vX1bxfnREMkeMFdSrC/CdcB9a+AQ8Y3UM0HGRIUE8p3qqNHoWYikRVt+1fMimTf/lU/3jh5zpfh9a9a9+qtBMg+wR2bzpKJ15+e2dfc2D40oKXIjuxzCpFpB494bh5QO3TC90XY4HT1GYs2Liz822sBHQvblMzW8Pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T15FCJrb5Xg9uovCcGEdfv6iJnqpAghinZJ4b4uvf/8=;
 b=KG6Mtrb3MuXRQ0rkuV6W7VsJoRqPvnS4oT55eatXgGfT/Dg0dvcWtDd4rj3NylfxzazOgY8rAEVqMn3QVWvaosPW+yM6ArKrpaaj6Qww98l0je+igcryXWk1c3fdEjmM34YvkD4uwSCxwfbZpLEe2lqgf7Civ9oNVl518KU255k=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Mon, 18 Jan 2021 01:11:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 01:11:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: remove unused message SMU_MSG_SpareX
Thread-Topic: [PATCH] drm/amd/pm: remove unused message SMU_MSG_SpareX
Thread-Index: AQHW6/7zncC5rH3yakef5vVd3AjO16oslbjw
Date: Mon, 18 Jan 2021 01:11:57 +0000
Message-ID: <DM6PR12MB26195C84716113BA7D0C72B0E4A40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210116115829.20135-1-kevin1.wang@amd.com>
In-Reply-To: <20210116115829.20135-1-kevin1.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e701d316-955c-4c92-a774-2eeef4956191;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-18T01:11:31Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c713bd03-e4b1-4558-9c74-08d8bb4e0d32
x-ms-traffictypediagnostic: DM6PR12MB3082:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30829784FD6FC78B8BD109ABE4A40@DM6PR12MB3082.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XXDe8gJWuPyisXZXRjlV5ylVfrmCp+Iwwuuyj+njJ8HjmJilzp00VzVPAggXY7v8dGTLwrZIroX3771nPq/NZFGo6XpVzIPeQN7s45HF9ld+V2TQME3ujBtEkBLBNhmWUdlAARWMzXdzvYqRIB43NlEl5JEou2UG85m0HnXm5L9wI3uqu7ZjU939ZDDCf69N9K+FHtUFzCfDt/OLytUZEXVk/AbmK9evcMKmo0yxuT3jhjej6xpxa6VtRUSdYDPyXhp2Uhwlld9dFSBDqYKIx1xrACzeYgSQZMW7rNbzIRUyBXgpynaFaVxut57vkS1VLatHy+hF4YD5+djuZj45Muaw8rj80gH9gYNaWmAf/LRrju20Yr5T19J+qoPPN61XQlDNZUORlVUdJ1qsISKPJIu21LvHI+O2EVouJVsucMA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(52536014)(66446008)(8676002)(2906002)(71200400001)(86362001)(966005)(8936002)(5660300002)(9686003)(15650500001)(64756008)(55016002)(66556008)(66476007)(186003)(76116006)(66946007)(83380400001)(26005)(4326008)(110136005)(478600001)(53546011)(45080400002)(6506007)(7696005)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1JUhUhh7Vin4bwYJ7YLDPY4QVThq7iP/k6DHWAzRHq95un+xM3yhU2aiRi3Q?=
 =?us-ascii?Q?+OAkpzhzXNzVsGmFj+W0in0kMBpRxSFGN3lbvjKVTMLNVFzaLPX3WRz0T40N?=
 =?us-ascii?Q?WHkwPAMuqBrP9pAIEryWq4f1rGfDV//oQIFymnp1o9VG1SmLFlZiL5ZH2sxV?=
 =?us-ascii?Q?21Vezq0VwsAzVkk5n5LQxqQUZs/a9ODwk8qKtkfdHr64zW/KWp5HhpiKpDyp?=
 =?us-ascii?Q?WrUiXqSU5OH5c5bR6aYwvX7UIQuqkc0S9Z49e9Rkob4TtpPzwwL21hXVJP9Q?=
 =?us-ascii?Q?b3r609ktOsdzbu+UtB40T6kmwf5iRZzleDzYa/dBCi5dNlk7BieZwIhF8VQe?=
 =?us-ascii?Q?7gPAIW8WfTz9g+71x3LxKnMG5TRyl1JZ5gNBAjevFWY7ebC1YWQmEzxOys//?=
 =?us-ascii?Q?q3Ajr52aM4DBzssxF2a8YKD0c5gt5x6v8ZnJYy67i5e18W+ZWv/opR74SOYu?=
 =?us-ascii?Q?Vjl5Pf5q0r3o2XA3BFrESp0up0kiCDboTHy+Ppe0DfxK4pKT886V3g7gTkI1?=
 =?us-ascii?Q?Z7NKUw6aJCGgfs50ODSlUmjbv3FEEyVJxBHLMEvbVrpU2aqMUr3CZ/z+uxua?=
 =?us-ascii?Q?bf1a2lgGj+G22pczscq6pKhdj6tSM+EHE/YQ+E13nt9XVKsLhhwbmlg/LaQh?=
 =?us-ascii?Q?VowaVcKTT7qTw2eRxjcZhpzi+Fxm/Dk4OH0yA9qs2ggBDs1Op8xGDWJR/Cmt?=
 =?us-ascii?Q?dr3k760l1f0NAdDLuInBCnzNDJNk/ekBdXdmrHlzGQEEzElE94CYnLP5ASVO?=
 =?us-ascii?Q?/zHD3/9AxWWM09S1Or1dQpDymuFlONMERXZn5u0FoAn27+QOLF8pwnR5XVl0?=
 =?us-ascii?Q?lYcCoF7FRK2Dwp6ioC8Det186n9Om4wo0dtBdU1kNqSY4eMeYAul/CCSHo0d?=
 =?us-ascii?Q?6oVtHeIzlBWStBXGLgoI7pTiH2czBWJkwDLeyD6pe3p0AXB3xArvz0cOHCUk?=
 =?us-ascii?Q?xY1k49AeX72nB8LKp9oI0pALjHfQWDKQmVP1CkNDQDE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c713bd03-e4b1-4558-9c74-08d8bb4e0d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 01:11:57.5559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bzYMJDR8b2bRsHTdystNGpXNgppgGwWzGgh0Im9kjtNtKWfEFjdgQnsKyG6k4Pu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3082
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Saturday, January 16, 2021 7:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: remove unused message SMU_MSG_SpareX

the SpareX is reserved by SMU firmwared,
the driver never use it.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h           | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c  | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index b76270e8767c..68c87d4b1ce3 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -133,8 +133,6 @@
 __SMU_DUMMY_MAP(PowerUpSdma),                 \
 __SMU_DUMMY_MAP(SetHardMinIspclkByFreq),      \
 __SMU_DUMMY_MAP(SetHardMinVcn),               \
-__SMU_DUMMY_MAP(Spare1),                      \
-__SMU_DUMMY_MAP(Spare2),                 \
 __SMU_DUMMY_MAP(SetAllowFclkSwitch),          \
 __SMU_DUMMY_MAP(SetMinVideoGfxclkFreq),       \
 __SMU_DUMMY_MAP(ActiveProcessNotify),         \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2f0cb0ea243b..3d639c530e2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -81,7 +81,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,0),
 MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,0),
 MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,0),
-MSG_MAP(Spare1,                         PPSMC_MSG_spare1,0),
 MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,0),
 MSG_MAP(SetSoftMinFclk,                 PPSMC_MSG_SetSoftMinFclk,0),
 MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,0),
@@ -93,7 +92,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,0),
 MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,0),
 MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,0),
-MSG_MAP(Spare2,                         PPSMC_MSG_spare2,0),
 MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage,0),
 MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,0),
 MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 6c8a8ccd2f84..dfe4eeeb4596 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -56,8 +56,6 @@ static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
 MSG_MAP(PowerUpSdma,                    PPSMC_MSG_PowerUpSdma,                  1),
 MSG_MAP(SetHardMinIspclkByFreq,         PPSMC_MSG_SetHardMinIspclkByFreq,       1),
 MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
-MSG_MAP(Spare1,                         PPSMC_MSG_spare1,                       1),
-MSG_MAP(Spare2,                         PPSMC_MSG_spare2,                       1),
 MSG_MAP(SetAllowFclkSwitch,             PPSMC_MSG_SetAllowFclkSwitch,           1),
 MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
 MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C78a1c9e606604a9679c708d8ba16149a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637463951301273401%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xlNMR%2B5DMYPbXyuWas6G0avj3am1Pvb8o3RtQA2302U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
