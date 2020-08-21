Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08331C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC0120714
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YvZU2jkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC0120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF3C6E02D;
	Fri, 21 Aug 2020 03:54:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB266E02D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 03:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK2klo8uxPMfeLjl18I+Szg3gBEadAT4m76sW5kdO3eMUbTRrBzkxPhIvWcj4d6bYlxiLYJt2cchXAdFFmTy8K27u+/igvif/wyYHAeLvQNxVk3t14Lb8r5ndU0wOOZxNYjX74WHURNcNA57N8i4497+/mJ6oSj01mJmjnD1JSs2E+YZGwQI1qQmMLZAljZcg5bYbw5mMGbwdoWtw4rd4cTuuGHTO1BOnobWLxv2RXAKz9TslWjoEpJn196GH8gXwRAAnObLDsiI9W2YT3iB/uCQmCAdKA1oUNcgJFH0hEC7jgfyg9GOL/UbWPUUdUkC1HrePulfW7K7cE/0Go91Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYEu6ciuG3Va0BiTZztYnnaZezlCPvhNi8jiq4xmZqM=;
 b=Q+fWXjnyp0x4ZvbugKD5mqWvN+PUdYJo8meH0sWQ5fU2hM4zjTR2o9aZp5aBWGjWOgBXjyQQquDkNDcvgGkh1h1jBDL1laGKAAzHQgGNmydeWdTu0wsUsXdY7WvJ5GYux2po3ez9SyhxVXtisk2nB4nbApYPhvrKdBFeZdrSIqDSyVAvm40T+3PpKW/EuU1LtZNOKhoxSiWsK/9y5fJ/+3Oi33MO8YWQVNYfMNO68N44g9dYyK/oo49sYbyw3K/ChL9f3CkmXAVAQWwJVM+8ad6I+1uXvwulLk6htQH3u6kDQYL8iWFZzkzylWj4bXSlrzKgPiqWHFfY5KCtM6PHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYEu6ciuG3Va0BiTZztYnnaZezlCPvhNi8jiq4xmZqM=;
 b=YvZU2jkD0+sAAoJafQJboCj35CPTzbnshw1GlQjqADuPpL48WDlMYA2z3rkndQJF53JgwZRGResW8AkeEKe4ZebfLdioZ57jzm74NM595EhtLgdGFfVUcMV8wZLjLT9iunHo82igKn1fxlZz609Y5H/alepINhoNEEwud3tKMFo=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 03:54:35 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::9d0e:bc15:1b8f:84ad]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::9d0e:bc15:1b8f:84ad%2]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 03:54:35 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: enable run_btc callback for sienna_cichlid
Thread-Topic: [PATCH] drm/amd/pm: enable run_btc callback for sienna_cichlid
Thread-Index: AQHWd25nV9yyuRVrpEaT+ZipOjH83qlB7l9Q
Date: Fri, 21 Aug 2020 03:54:35 +0000
Message-ID: <MN2PR12MB4175E837A40CA60E7E4D218E8E5B0@MN2PR12MB4175.namprd12.prod.outlook.com>
References: <20200821035122.7711-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200821035122.7711-1-Jiansong.Chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-21T03:54:29Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ec80a1ea-31da-4574-8d0e-0000ee70a532;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-21T03:54:29Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7af7ba66-be99-46bf-8c13-00007b483690
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a9718af-51e7-49fc-8471-08d84585eb3a
x-ms-traffictypediagnostic: MN2PR12MB4240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4240FBF102471B99A97F39AD8E5B0@MN2PR12MB4240.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFbGO2qg0t26c+6b18TMxtlYfcVwSKEN2p10ZwHcRa+Y/Q1ANH74xHllTnsH0EfyrrCC+7gwG80Nu2y36RSeLgJVlsBPln4kwo1uM7Sz2dSD2QjwM/auxVqu6UwA3hr+xNfhW7Xed9xPkxb39wm3R5GOpuSohw+1C1MrFxP461/hVG66O8w2QMJLXXThAFGvSygo9JgqvQwpZa4H5oDqRm/mCXKAWNk8MjK4GNkB7p7MV/oxnZynWa0Kc/Dp/203w1LELdb4dsBSM4L0ZHOJXXjYevkU/XGKwURfam4otjbO95NlnQhT6uxhsiqKm7s0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(66574015)(54906003)(5660300002)(83380400001)(53546011)(76116006)(64756008)(9686003)(66446008)(66556008)(66476007)(186003)(66946007)(7696005)(26005)(8936002)(2906002)(33656002)(316002)(71200400001)(8676002)(4326008)(110136005)(6506007)(86362001)(478600001)(55016002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: XlDBZ0V5T8w+mrrFqI/7J5ddOR4qnOPlHLah6BXV34jVnHYvZS9tH7Gs4e5O2VGsW3iBeIs9s8LnvPQGKh22+y6USm11jFDAva1Jr2ZLQrFkHv6++iH6ZTPMU4+n0qiEcyQYWpCybdpfmbWqTMoPUB4oggTcFvis87JVpFcE+y5hxE8zqfd+udXRK1V/uVa8DJl4zQ8aHoZI3xKImiSBlbXEZuJDJNrmKa4rT2JeEeNTeYhfBtVtc72+UUR+yKy07TfaodvBVbmE/32+o+kpkgSvPBh1lffqz7TMZYz3ecnsfnDqWIEfs9LPoqkJWiYnYoBFeNKWgAYAjAr/r3s2OlETi+NpVsbSLtP0vNH0MLAkaeuhTRrGaXm5mpQfrfQNAEXPpO9RdMFyiKEFQH3Pcy5aUPgJR82Sx8v63CuBulE80dQcmLhp/W/2QtXogtK0+5eKzBGLcKQddzjI3nUBIxW36YVvdcCie4Ov/OUYdEaFZRajLin/r/kVFurDs+YmERuwlCo0Q4e133fZdhgrBO4u3SglOtwESC3WRi5nZHX8QRzEHD7fEX3P/a83+iNm/3VycMvfLxTrzozSP6Q9y6t5v1eMUUX2OfjP3knuRUODI1WonZdw8NKkhK0nA/1/JZbP8UOqPok0NDXCuAfa8w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9718af-51e7-49fc-8471-08d84585eb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 03:54:35.1516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4WHxcTMkiJkuyhxt3U6e7ObPH7JJ4SJKrEcMzCNsV3s74rFVSOvZRRu+MVx9+q8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, 
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Friday, August 21, 2020 11:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: enable run_btc callback for sienna_cichlid

DC BTC support for sienna_cichlid is added, it provides the DC tolerance and aging measurements.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I93b439b99c1bf365194d61385eb0fe0251f27041
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 8ffa8b71b75f..d2320ce7ef0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -95,6 +95,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       0),
 	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,       0),
 	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           0),
+	MSG_MAP(RunDcBtc,			PPSMC_MSG_RunDcBtc,                    0),
 	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   0),
 	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            0),
 	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            0),
@@ -1735,6 +1736,11 @@ static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 	return ret;
 }
 
+static int sienna_cichlid_run_btc(struct smu_context *smu) {
+	return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL); }
+
 static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)  {
 	struct amdgpu_device *adev = smu->adev; @@ -2792,6 +2798,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.mode1_reset = smu_v11_0_mode1_reset,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
+	.run_btc = sienna_cichlid_run_btc,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
