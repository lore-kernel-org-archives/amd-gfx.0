Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C70CC25B5F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 03:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B6C10E379;
	Fri, 10 May 2024 03:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JBnakySq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7F310E379
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 03:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBe4UocSbHUljOWRwSbLdk4rYapdZXd+pUgYdUtCZs+Wwrn+65a3KEGDs/nc7P0ZDol9O51QoxZu1wzSoy4V0BLxwn76nVd/eirPyWl8v7WDZaVASN1fkp/BlIRedHqixTDDYHqJhkXtjdDmoeJfljHFLd4ITrLKG5ZqpyaamNQDUPJYKcm+SVKFjEOYpAZWliE3DSCRcvWYiv+Gu6HNE7E2njfY9gi2m+WqombrqzusQlkX2UClld/jVZlc1ObNeY1HLlAC9z9RvmNctT5aneR2d1OiJ6nkl7Gk0B+3tPB22/x6rEOaFCxHDnLKnWrzKr9YrQGMv7bGsb1iBQ3izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W098yZN9o69bOsGpeLi8BBPTuTm7NLtVGKUd+KEE3c=;
 b=brhH4S/0Hr6NBeNtQIAYd4Zv+rrwI1WulCNP0FP0A24XX7Tk+CxFDEwL8xCgaIwzBPzntphaYguIHKHGMh35U+tfXdBbNLOMugOmVQFgVF0ngafc90f6gabiicDlZHIugITPucBN1IYjzHbdrrf8AnrA0XvCQ2USdx0TXPTXtsLQ3zwtAOsQ3Qck0QmwCf8tZrUMASdz9rwJpaFWuob9mvk+NhD/+rkvZOzJAbxsb+4q9mnPbTQ1qElN3Srs60vVhLKYPvQH7t4QvaX0CaWonPRFrV6zulIkkbGtuwICExxlQiKRqaACDx1WRSOHQBZgyKbND0J+dYPSSrKhSy8AqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W098yZN9o69bOsGpeLi8BBPTuTm7NLtVGKUd+KEE3c=;
 b=JBnakySqJ52M15c1BcqxkmNeB/merIgFVdQmuGiDB9foDTQ8hV6Lrr2SgtSSMs6tVgHzBoAcah3Ty56SILdPa7KYwebMB6RSD6Id33Wl9LPKkRJyeDyvb9L6ZGaFNDFNMaPH8YrSMwp5QUrStaBgkfQb7/7R+XB1xai8vFXBdio=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 03:34:12 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:34:12 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 13/22] drm/amd/pm: remove logically dead code for renoir
Thread-Topic: [PATCH 13/22] drm/amd/pm: remove logically dead code for renoir
Thread-Index: AQHaooVDxv3CTET0+0ahSuGrbQyt8rGP0FIA
Date: Fri, 10 May 2024 03:34:11 +0000
Message-ID: <PH7PR12MB5997C07E0889B680C0809B7182E72@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-13-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-13-jesse.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9d931ed1-1ee6-42e9-bfbd-33bcd6ef8a90;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T03:32:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA3PR12MB7805:EE_
x-ms-office365-filtering-correlation-id: 72f0a49b-a265-4476-db86-08dc70a20ef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?j+ftfj+POyCM2SB1gSe4cG91KwyEIcVjIZa0aU5oDz2g1cAkkfao0BkClYSw?=
 =?us-ascii?Q?WivpPSnYjM57YBKiT6cB0li+v5qkWkkzmZPRNlkZo+6o4JBnQIFVb+Ql1h/S?=
 =?us-ascii?Q?SAH59z2rR/fH2ADDL3jq0WfV6V/UCaMK5VBxMDMc2Y8a3LSTiovULLGgbo58?=
 =?us-ascii?Q?PJvmcRSLe/DUTKRejhO3kHOHvZcwPonBCISkF4kKa2y1cFTQKrWYTM7wJLSj?=
 =?us-ascii?Q?OCobQ1pGJODlBf7+nImEyaW3YvjeT1mcBvUKKSnS34868khcaqcRlGnJedSx?=
 =?us-ascii?Q?dsCmvrmiPVjShcU5AbEqj8PhDGjsfZ9XjLv9qT2J5s+IbVCo28n7ULlWM+fw?=
 =?us-ascii?Q?y3gc1E1/QFFZKaCtRyow3JfQdnYeaIM9/0UAbQiFvKUQfXj3eJZium1tz+Gu?=
 =?us-ascii?Q?4UAm6cTv1GlR3Fa9741c/xDjIgYXzjxbsfpYUrfnb0yTCM68HmMPjqIC6P+d?=
 =?us-ascii?Q?3GG1c75uAuoyJ+6HwS/YhidKAIUGha8b42fFXu0QZmHz11edIEwSYJj5OaBr?=
 =?us-ascii?Q?QPn3R3O7F7ZbUaljIUwnJYU6iG1h7ZKNDzlKFVIyapvMmm/lEuP6mSSHQlYz?=
 =?us-ascii?Q?Co8vSj9KvjTJSLacfB9/wcE4CSx9Yg3oePQ2QDO2P8LhcSveDkNZ4pevSQDo?=
 =?us-ascii?Q?dLWA/JiUNzWyRAtlW6v1XLfkYfcoG86achkzu6EcNsKKdoomrKBqiaNc8Uvh?=
 =?us-ascii?Q?CD24q8iLfQURnLi6vlljRnebS+liMHxkey0zQoR9fBVrpkB+nq7mqEswxjV1?=
 =?us-ascii?Q?R7goJVa4/On+UzjdNfgcDOViGofYw0eA++cCfZk9ScFSVbKn4s8P2bZUpmcu?=
 =?us-ascii?Q?EggvWI2oiP2c3LkvWDazuqHaWIQZeo6+pJHtidCU+/GXa1XlPLTcjMvIDlB8?=
 =?us-ascii?Q?gdp45alPnOmi05UpZF0qQyHtn+wKHlc5zIbkj3E7Wq5JdXiOTiB4oKuAAWmj?=
 =?us-ascii?Q?O1RM0dl+Nvp4uNMRy32kuKlYSWQ9UK+h9K1tv4WdmzedBsbJyc0g5HJN1uC+?=
 =?us-ascii?Q?j1BbyJS6K6GBB5hyoD15ftcjiJo65ZgwPHVvKB/y9IIEMSsIIpIgwYrdPe7G?=
 =?us-ascii?Q?aR8VkNFK4gwFGAu4aRyTZ+YgILLEzi1K/f95zfwhXd/eHYvcA1FlLjCX9xpE?=
 =?us-ascii?Q?fxw/XrHiemqIjMOb3uFu5a8xCvuRhUlGithxrMqHUVbec/EOkC5b5Fd/2tNM?=
 =?us-ascii?Q?GYiG48ywH8orDCxUkYqrSlEYGVVg+ArBqvSNYDZjcwJjqT8Q79eZ8JBBiz4G?=
 =?us-ascii?Q?dGHhyPw/HgBK9auYS5gGcvdQKjV5uN/9ttZgw/pZi1b2MH1Hinga8hslnhsX?=
 =?us-ascii?Q?jlrjbcMZ1A0gKfNOhcaazk7ocLwDfJllIfGc2wQdC1RFOA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZMaAf0+iFFafLjkTrrfsLl2U1fXFvX/hx0vj5oDJMHdo+fZgonzymhelcS2R?=
 =?us-ascii?Q?Hr76cnLY/7BZfPKNRQSaOpdhpbm+mZO+I+kEavOLfAq32LtweN2Jrd+ohtfw?=
 =?us-ascii?Q?MoLBqv1ApngypfTpFg01xNrMnR3+HReqkRo9T2O+WGVXJV7KhJgveWDBRQRr?=
 =?us-ascii?Q?XcMFtMiTBTHU88djbosM6uTH53i8Et6wcNdEcQ9l4K6aHKxX3qmHL9S6yb+l?=
 =?us-ascii?Q?DWjrcOgMKFVR1E0w+GPrqAL84qlwsocxJtLy0bHvLLfvedscmFn/RZ3taANa?=
 =?us-ascii?Q?97fXC+E3eNIoyxtxeuf0PZ2dKlm786kszvmh7aDLeVIY8nNfSlyBudp5ZHYc?=
 =?us-ascii?Q?xjyW4+Ewx3qyym0FaHXeqEWAbNYxkn6zXlkacelYNggTv7weXyc5fH1Bo9/3?=
 =?us-ascii?Q?3lV0YNVfvVTGy1yrqjKfi5PBtO9JpKB2qTzUL0fn0YE7tYULioazZQ8P67/C?=
 =?us-ascii?Q?Y7dNm0/hnkjMWyuCOMInTN9JQ8/rywwysAlytv1KXhAg8tXLGjGKlgjrpVR8?=
 =?us-ascii?Q?faymZeYHRvgVoTwQnVirZizaDIYU1eV0pJuS+qMpJ0fUfNSdABymmaj7Ipsk?=
 =?us-ascii?Q?IqGkwQlGcg2ojzSjA2aaqtveUFSLQXKrx23/wckvXaSidlpqDqYpDq/WNgdb?=
 =?us-ascii?Q?c9CxVsMwUqZAq45d5TizV1fcCWCJz9F4JDMP1KqWKWCOd5Zmu22Si/4s/zaL?=
 =?us-ascii?Q?+PxY68KNpxbF3huhkhQy8+BGVgDX3zd1gApuzqblrixsq0R0It948pXzX1fw?=
 =?us-ascii?Q?JqPuZPXekaI88d+O7LpxyrztN1oRKRYiLb2iYB2PIRiIfwsJUQanq1HVOb5o?=
 =?us-ascii?Q?+wFqU6ADggbApqZLp7OxFy0Ggoo4bZT/3sSvgo2jtDqGK10JofJpcncFvWat?=
 =?us-ascii?Q?M+IuNeWrr77+RV3tJS1E+rXlS0nutrPuUX2ekC620PPk88PXqAQUppF8uRsh?=
 =?us-ascii?Q?SYe1Kn/HTWH0Dm3a27Xb2+CLbHppBlolLYAiMxY7ikS0nX3RHXk4b1KxbeHh?=
 =?us-ascii?Q?JTDi2Kqohdk9eC8AzQmY0Af71pHykVP+N5UkuixvZb3CURh1Tu37eJQYxB/o?=
 =?us-ascii?Q?oFL8O+L4vNihP2EJu+T5EyznM6L2opvVnwlw+N2P7ni2nEdg10Tr15oIVULU?=
 =?us-ascii?Q?VfFjp0MVbxtbU3Tx8Jn+OVq1VUSDtOWWCAJPFjY0n58luOHu38HMRdEDNADN?=
 =?us-ascii?Q?V9Bkx2RiLJ8kqoSwxUJzDFp8nGk3DTTYloUAqRMKExykUSWgQ1t27jMlsjie?=
 =?us-ascii?Q?8qVNVrBm0wLuEIj0bMyv9604Y0N1cB1u6qU0iu+m3dFeUmsYAw9441hV2b3s?=
 =?us-ascii?Q?u8l+2QSrePdJj1ZrNqqjpfC/uQDdMmCfLOOrPD8RTnMBHDmLbBuPGCgBOWGi?=
 =?us-ascii?Q?Y8uGdG25wqFDOWGW7h8t9S9tLL6KM8qGo0BVPA3iCFc6dVVFNMjyny9zEYiV?=
 =?us-ascii?Q?fYMMi7+h7vkmZIB44XCG+IvwTQg3My6rUbEW6ID+HDn/w8XeJuXnaeJkC+8p?=
 =?us-ascii?Q?rm/6cL+RH7GubWDgHwta/C+KaRVPi4XizufG4xtbQ3nn6BlW9fE0MY9FSM2V?=
 =?us-ascii?Q?y5xAE37rw3GW6bmAHL0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f0a49b-a265-4476-db86-08dc70a20ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 03:34:11.7088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MuSab6tnwkYWQ2HEpRn8KnVoCD2HtkHUPGAgpCA7KhDugAKjwn25XmVCaZCe+zM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please add following information into commit message.

Fixes: ca55f459f5ad  ("drm/amd/pm: add the fine grain tuning function for R=
enoir")

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Friday, May 10, 2024 10:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 13/22] drm/amd/pm: remove logically dead code for renoir

The switch governing value clk_type cannot be SMU_GFXCLK and SMU_SCLK.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index aeeba0d95c9c..cc0504b063fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -585,8 +585,6 @@ static int renoir_print_clk_levels(struct smu_context *=
smu,
        }

        switch (clk_type) {
-       case SMU_GFXCLK:
-       case SMU_SCLK:
        case SMU_SOCCLK:
        case SMU_MCLK:
        case SMU_DCEFCLK:
--
2.25.1

