Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC45C6FD1C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 09:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B3E10E167;
	Tue, 14 Mar 2023 09:34:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B68CD10E167
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 09:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZB+n9akS9vj8ciP6AWWkRMQcRCgCPPgfSYuBZcDi2M4BkIt7yujdUqLg9w1SwhKK/IiDBNbIJfdTWnOHZT0HMlHeTxkbiplHJVQqdB79eLBOoX0rJKBduf7zeB1EDYaEvurwfYZyZnFo52mZLTZbt+G/rcapNd3MP64Xhy//JOiC68ml0Ixg+Pm0g9adgwZh6RQs778XprgL4zrze3eVM5XeRhFoUTicGatOIiyGkkoSf05OPz/t6uq4hIcvK1CMRwLHUINJ+HLSauap2Y0PyeGdouxGO318Qys07voICb9r9v4ueKODWaC0f8sY4P15Mc67q5sNYhay2goCa/P0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Dzse7qkHjWGk8enVfWaoXhOuJSz1vdAVQrkc+MitiA=;
 b=lvaU3/3e/vV1AW23K1JxVgOwHuu0UwKERQepFusRFvOfmRaaaGqoraWAEXkCa8Uy/FkK68plFWTwCPhCJeIH15yDQCVGkj7e6fWH9wyvARkEQdln293WDdI86uws9B3L4W/tv6mKmUUF06NWj3w0cjI78suEGSGZ5VznWBsiZVJ36G581Ee6zVm6E94L08iT7HQHMhyDy2idgLo1eePeWBPtAXoa4n7wbMF+FfKFp/YRvTti+GMmn8xWB3Lzc9SN9gtOxWFxPlz6nMvboHs8+1lEwSz5LG5YDdt8UEydh74+StJesMA3ZXzI2kxFdVzutw1DXsSqMqgz2QFhOVuYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Dzse7qkHjWGk8enVfWaoXhOuJSz1vdAVQrkc+MitiA=;
 b=2gEGXv0bZXwqK5TdtLYNPwARctN53dAPACdA7kWyq0Wv33UpblP9U+JNPvQrIknRWmaWDA5AlEmUPc/GjWkiZAVnfcVaIP9FRzGupLhRm5fMslOyW+w0O2X3gwJ/RciB2BiO4HD/eoQY0F6/tGehK/4FiFt/n9SC3tB+6hZCfX8=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 09:34:37 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2%6]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 09:34:37 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip ASIC reset for GC IP v11.0.4/11 when go
 to S4
Thread-Topic: [PATCH] drm/amdgpu: skip ASIC reset for GC IP v11.0.4/11 when go
 to S4
Thread-Index: AQHZVaEb3JBTnUlO/Uylia4K1FDDZa76BIFg
Date: Tue, 14 Mar 2023 09:34:37 +0000
Message-ID: <BY5PR12MB3873220EE4CD7B4A78D77133F6BE9@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230313114209.148894-1-tim.huang@amd.com>
In-Reply-To: <20230313114209.148894-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b5a08de3-fb51-447f-a350-79596cbacea3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-14T09:32:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|SJ2PR12MB8011:EE_
x-ms-office365-filtering-correlation-id: e74c6722-4c46-4906-0674-08db246f5409
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vXGDVEKvZtoy444gt2dA6VhCD5jGYutP0lB7/dsdJxZltMJChpQy52LFfOKdKC3MKQb2IDgW+Hyvwt7rsaEPZU6YSXgnqA9V29411hac6Me5I++1SXJ/BzMAXq8o49arxq5i7LbApmNrGpu3USOac/yfrnR+DVqMpXITpaJJ2RlzcKur8iL5oqC2p7amBF+mY2cGMeAMT/8pYxlFl7kugE4T9xz6isEcnMCyBi0pnvBwAEfGReDjk0qA+lLXZFN9Vme4lHMP8fiz4IZj2bX0KqA9kFj63GxIPdonTiDkHhhds92zkQQ9wG4Yg3+aMH+8k6IRcFxZ7agjdcb2ah2UsuqaicgH4Y9IQasJF1ziyEic0rCibWovN2fYp/Y4I8cAHEzyRNGajEZv7AKKgA6oqt9Jq+OHbalFcWuZf71RzjhPkRt4hbSLrQb1E7r/8UjwTcDLLaIXzVpf3Rdsykv+2jWxURwKAiIt9XnLAjyAg0A2GPd5Me+1VRG69RWU5qdVLH33uqn+iOIs+4tY2Po9CIO8ok4rRkP8J/X2vB2bu0cUDl4WxI8QZHMtiIvKl4UYMN2k9YKSpAAfxIj8MdSS1/HPkeKWO2zbpDOWPQ4SHluhBz2dmJuKAFCGrOGW0p4M3F5Uwy3l5tz130wbm3QLmge3ihFiLa0jUmzABdAl+8/AQcfUuF//5ys9Bu9F6/xDXN/Y5abjBbQZMM1Issog5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(5660300002)(83380400001)(186003)(478600001)(6506007)(7696005)(26005)(53546011)(54906003)(6916009)(38070700005)(66476007)(76116006)(4326008)(66556008)(52536014)(66946007)(8676002)(64756008)(33656002)(55016003)(86362001)(9686003)(71200400001)(316002)(38100700002)(8936002)(66446008)(122000001)(41300700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TFEZh1UW1OqLnmsekP/Y5qsUXq5//FA62vlUGgeoXhBHzkTqN1KpjgR13nRc?=
 =?us-ascii?Q?TmpYNxSUv1tQCuwRwqKl7yKMXPflmI1rUrnT4hSaNrApHpeFIESkAJvUnp1/?=
 =?us-ascii?Q?1t4PdzlBMNlU2TAuJ52Tc47vLAgFzWKmMEY1A9yTN1ELkhsSRl2vPFDMr32E?=
 =?us-ascii?Q?FMT4dTB87elNS5v1mX28wagkDBeXfXF764j5R0Y3RJG0YpD1gXnloh36RQx8?=
 =?us-ascii?Q?zyB0y9IGZmKd+4+hgqSc13CEhmfJZbsnroqikYPEXevNU4cF1WZZkWLM36+0?=
 =?us-ascii?Q?tKv1WcAFgpGEB6mFzLVl+ulR2K0YTRQyjagyOOYlPF8ouBCfTWlIJNczwB8x?=
 =?us-ascii?Q?lsgQVubK1yQHA/03C436GsI1A2fJAwGNBqnM/oth9AL68sf9O/8Od14BdErV?=
 =?us-ascii?Q?9d409jTdhoBSXJjvi0ds5D2IsZs+S3W0nV2cGQ9EBi2kN3l6oRIQDmV1cbJC?=
 =?us-ascii?Q?Uf8XthfhQOav/WrIqGRpj6BhAVSUyuI7RBbl153zBnAncLL4GXbS2c3WbZON?=
 =?us-ascii?Q?0XHaTSbcDGoZeL+A50p4OUVy3/pxTlfSCAWubvEYJNNGnAcpIvNXSejWBgJ8?=
 =?us-ascii?Q?Pq18FJ7UFxsDansehi/biNb6TDBkskvvz3KTsYgq8rpTlYjf9LSZpsNQ0CtS?=
 =?us-ascii?Q?+/PRB084anWHpra8A3XGQarWPVy03uN66y3I+UOXXbi5E69hnjFWU7h1XFGv?=
 =?us-ascii?Q?BizJsR4v49Guf0gIa0pgeNHmmycZKc3lx8+hWKguG2/n291P150hTlKt1AsQ?=
 =?us-ascii?Q?6bLfkDBE+tHyOK/9i36J+C8ftOqs6uU2xSjfbDruEgox269IK9PjjROtlMm/?=
 =?us-ascii?Q?NxCo6JwnZ4XScL1KW5RSzRtlTai5oyHTs06RdYxAQyke/WE1Q9A4KXE/GH7U?=
 =?us-ascii?Q?Uf126f6N3IC5UqRN5WuWXfjf72BShnlSZzzZDnCdeXd163BhOYjRq0C9Rf5k?=
 =?us-ascii?Q?bFDpSme5jNFEXBZRgtoQEfC3H85Tu0KTKnHsgEwYaYDiz74kIHXFy8XwJrRF?=
 =?us-ascii?Q?4knl3NLyIFO4L08wqN2mxX0/sTKJBTWsu9glnjrjPsbn0hQBRTNnwZx5sovV?=
 =?us-ascii?Q?LCSxC6XGKaYXU4kv7gHDr6cGdyoa2vvqM9V9qUIgufaUl8ygHZFtoGAjextX?=
 =?us-ascii?Q?2Z1LbqirDp0v3SLtKY8Ibixn14QZgw/XhAiMLWrMfrhrOsjTzGSJDi9ATp/E?=
 =?us-ascii?Q?FwTLSvYTWCxV2Ej4F1YYFmkMDTLvUrulG31vxoN7kcZrvkUtcjXfw0C8M+A8?=
 =?us-ascii?Q?hbclPYuoCg2lBrT+gMuz85d4ATCADzuyAsLV7zVrcVAKj4TftWPZsJVqvrmm?=
 =?us-ascii?Q?LlB6dpPhRnV1EYFOmwAf+XtVPg7WbnmwO6aeyCylbxZCCgcJuK0tfg4tt/yJ?=
 =?us-ascii?Q?zRsDEnkKXyliMbPBv7lxKVCTrjzPo8cUlH8QRIDj8l2xR6Za4pZB/rcu3QFg?=
 =?us-ascii?Q?QV3yyeBn3Ec9dOddx3/0Gy0AXlIsNDcUcaIw/tuSPwk2OyYx2edCZozrKRCD?=
 =?us-ascii?Q?CqdB3CkVJyidyPN3o+ShiGEQz2Ff+qg7V8XF5k6XJZQAmHgDtAafDAwGHfM6?=
 =?us-ascii?Q?MEkq+Jbegpu3WYbDg2CZRjlsQN13IdjBbLu5bV2h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74c6722-4c46-4906-0674-08db246f5409
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 09:34:37.2592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /u6nJZRbPdfU6kWmsgKD5/aXnKPQp8MQEJwa13lD2aDZKxPkrkl9ZlEfARkODKriM0+PWvFJWT7A6GqiV7jcZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please ignore this patch, will send out a new one to skip ASIC reset for al=
l APUs. Thanks.

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Monday, March 13, 2023 7:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.com>; L=
imonciello, Mario <Mario.Limonciello@amd.com>; Huang, Tim <Tim.Huang@amd.co=
m>
Subject: [PATCH] drm/amdgpu: skip ASIC reset for GC IP v11.0.4/11 when go t=
o S4

[Why]
For GC IP v11.0.4/11, PSP TMR need to be reserved for ASIC mode2 reset. But=
 for S4, when psp suspend, it will destroy the TMR that fails the ASIC rese=
t.

[  96.006101] amdgpu 0000:62:00.0: amdgpu: MODE2 reset [  100.409717] amdgp=
u 0000:62:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C=
2PMSG_66:0x00000011 SMN_C2PMSG_82:0x00000002 [  100.411593] amdgpu 0000:62:=
00.0: amdgpu: Mode2 reset failed!
[  100.412470] amdgpu 0000:62:00.0: PM: pci_pm_freeze(): amdgpu_pmops_freez=
e+0x0/0x50 [amdgpu] returns -62 [  100.414020] amdgpu 0000:62:00.0: PM: dpm=
_run_callback(): pci_pm_freeze+0x0/0xd0 returns -62 [  100.415311] amdgpu 0=
000:62:00.0: PM: pci_pm_freeze+0x0/0xd0 returned -62 after 4623202 usecs [ =
 100.416608] amdgpu 0000:62:00.0: PM: failed to freeze async: error -62

[How]
Skip the ASIC reset for S4, assuming we can resume properly without reset.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 8fa9a36c38b6..ba02b0d9ef7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -980,6 +980,8 @@ static int smu_v13_0_4_set_performance_level(struct smu=
_context *smu,

 static int smu_v13_0_4_mode2_reset(struct smu_context *smu)  {
+       if (!amdgpu_in_reset(smu->adev)) /* Skip the reset for S4 */
+               return 0;
        return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriver=
Reset,
                                               SMU_RESET_MODE_2, NULL);
 }
--
2.25.1

