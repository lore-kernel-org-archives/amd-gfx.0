Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355ECC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 23:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C285D10E5F6;
	Tue, 11 Mar 2025 23:03:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTmQxf3l";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F041210E5F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 23:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDnI5wGyQuYpruyI++P4ZyMznJC1r9HkrmZhF3aKiwnrMeQ/N7j7+rqB4skuoiwvHRsuzezAfLy4lBSDzEo11Vlw7+W7YDvce6cY715MxljxTbNN/VIHX12wRnyTIw+L3LU9oTy/snurhqQTgzhh1rcV91UEjoXUgQLWQamLfbBBg9uzsvnFvgiBpqv6jspHEJcjMHCff43JYpTOYnrZdUjmJ/eWgy/JWVlvaIDOPCP1mEXGPLmeD1HjPEelv9ITLbn16TxE6bA4/qi6N8QXMhe2Ybtyi7RjyPd1lA/TjjX9WIVC4dXGmoIeRrDY7ym1AvS2jQJdD5rQMQuroDYz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEIqOVUQ7N3YSmZTaJHbJJPqgPqeQCE25d8kHSAI80s=;
 b=PtLdL+INehgwyF5h0zFSWg13WjIoK1gkMBJ32fWlAi3Bi3Ee9qPpLLZCv7+ktKXupxglGRCTD7o+c7KKmTphqDsdj2VvM2zBuunejfF9opeqNIRYj5H2V2X+IKBh8JeIH4EbA62PqvhMpVwTWMHSShNtEC9+w+/5vrygZ8w3GUfYlMVZQpeo4d0NvhFYFQuqpqoh5ES86FxZaKtexe79pTgRGITY//igAT2YUXk9r6r+X4ZMOzRKgfk0yn1zUNIwxh09MLgEZeqLBxH+d/6x54K3LLwSOWTq2annTIiLvSC1ByaqM+QttbgY6118yOYWAQUP9M03htbI+68XJI0QKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEIqOVUQ7N3YSmZTaJHbJJPqgPqeQCE25d8kHSAI80s=;
 b=oTmQxf3lGkkBZ6s+2FLoFyMTp6ZVIcT8m8sW8GKwNJLYyqT12SOtzXmYadDyZKE1F13a1wraIz1GKzwqHfFlxi3dh/hXn3/AjXzg7V2LHVq6wpy0A/xIEQlnQ79X1pcX1eG1I20hEB5nu3iBhjWqZrYlPFB1bxrKNlmJQqQmCXM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 23:03:48 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 23:03:48 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: add unique_id for gfx12
Thread-Topic: [PATCH] drm/amd/pm: add unique_id for gfx12
Thread-Index: AQHbkrHS+2E5SnSPIk+GqbpGW55Ha7Nujikw
Date: Tue, 11 Mar 2025 23:03:47 +0000
Message-ID: <PH7PR12MB59973577770BE75F640D69EB82D12@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250311181649.114559-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250311181649.114559-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9f844a47-d6aa-4739-8dfa-3114e5f8b0cb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-11T23:03:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS7PR12MB5813:EE_
x-ms-office365-filtering-correlation-id: 9d915680-0957-4964-6a19-08dd60f0fb3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PLWzZ+DfZ9LL3NZdsGLrMImMuIzAYSTOMFYLXsbHZP/N+3rBrEwR7RUQd7Ms?=
 =?us-ascii?Q?DVxDbRSlM3iYBd52sJZvwVfsrw/9M19CGVlP0CYS6/K66OcvFGzW6p6nEVR4?=
 =?us-ascii?Q?QqG73y1VfYLdUxUQzEsmtiFDgiMQlMXko2p94qnGeMJVNEQ628/HwHGd0qRA?=
 =?us-ascii?Q?+yvi4l7JOkH+lsPKzdK8MzRB0tttPcvc0yA0SfWFMTa+DGPaLfaSwaNKpwJr?=
 =?us-ascii?Q?KPiUSb/3ZCy4lxV4clJzUmD5vIFRnD+DVwBxS1G1W/tyoYmvV7pxtv0KFl0S?=
 =?us-ascii?Q?CHuc5TJSEM7Zrrq0/bBZOV14XBdGmORxNtPNdUyg5NQVDa+SIjZIGlUTtJAE?=
 =?us-ascii?Q?wfw9AA/+9ExxpyehSNqqIRHBI4vJ7/j9NtBCmvLHM/Q9Z8+fPfKhEpoCFHc+?=
 =?us-ascii?Q?LUpIUvpxOumy0SW7Ku3Cqig4GRjO14acJJZ9scK3Qf+caRQ9mrw+QQat1wHR?=
 =?us-ascii?Q?L6QEqIiyGcrCh0+xxDsVlxW1dNkXHsyNUcULno5Q5cTP5GduHGM5QOHSwU5+?=
 =?us-ascii?Q?0kQbNkOvmlfP084h6asWZOMxlQ0BrJo7AMcxjN/Df+LhrCThcIWZACdx+Zvw?=
 =?us-ascii?Q?CdymVeEDxkCgpPmqVDeKyi47JlbK+L2V0nv+QJCZnt8yP7I0rOmnXiD1Erhl?=
 =?us-ascii?Q?7QybkHXSxkHpQPoXVQWZUL+N2Xx3N2VNXUJPf/ck8GdBcs0oCb/zM8GOQCCX?=
 =?us-ascii?Q?/Mjuc5P1GCWnrdf4pwslDngZKgP/urnxCkOiCTxzwvHktFrlDsu3Y8T5SLsL?=
 =?us-ascii?Q?SbTXOwaM0YsYRj7QkJemUDMSEj51btsWdBI+AsGLjjHz0mZ9nfMfiEnd+CS+?=
 =?us-ascii?Q?2BWcnkQZ/V9N01z0E48KK47XVE4sYShYFwkYYdfWMOqdJaokDH6FIFU3+8a0?=
 =?us-ascii?Q?8qT8njaaB4fzKE0EGq3pbE198MyAmVi7GLqtu3eLLN/LMeEU3R9dT1Q2KtBn?=
 =?us-ascii?Q?G5GDK8bPmoHwX670Eb24GaCg/tR4s4QPKYOlyZQjRClE6hy/mR6gpJfmIjnF?=
 =?us-ascii?Q?XDlyF+eqzAv4qiblOwA8NF3NUDXx4s1kOJhgfKKllv4Q5Hc7YPFkekhLGrLQ?=
 =?us-ascii?Q?nmThQXAIYNl45uqMcE6Wu3VYGdzKEp2vAdmEw1IUbszoMQJLJ3XfsPuBsu4A?=
 =?us-ascii?Q?T0mDXmOcItv/aTCeTSk8Ffl/+oIrD3ZSgsk/IL6cE61TjeiO6boL+wvz+CV7?=
 =?us-ascii?Q?MQ5Ti/8aGwamjUBauCLxwf11b9chdYzPrzQA6ewXiNU+kCPB+udvsHYodV36?=
 =?us-ascii?Q?U5L+XVBSMWObFyt57mCadzsSeUD2CdqMRbF6a/5dSzvEY73eM/R4rlsSNZ0p?=
 =?us-ascii?Q?YZuBrgvTePYoGxVcZRNWdLyJcJWbKLWOtCfbFaeQWFcVWBTpsvHgUjt41L8D?=
 =?us-ascii?Q?2V943g6S9+wKC+rCsbmypj45+zbYLbVYb4iAmyzcZoeHruIRmrIoT2wwiwWQ?=
 =?us-ascii?Q?DOqY2LXvNDp1hrgMBVuMgeGIXjMyEPsQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c2FfFCqTJlt5RN5qK2LVRi8X3vlPy6WJj2+QDSyLanBoJiBi0w7WAKQNR0ne?=
 =?us-ascii?Q?US4LrtMliTDiD6sPtpHHO6t76vxCeeCq3yqvN9nEqsXb128T4cLShJOch3+S?=
 =?us-ascii?Q?G0gkX4GapijVyAEQw8wELsKFl+pmdokq1aAb6YAt+VynWEDScBHDy/Vk7v/m?=
 =?us-ascii?Q?Xb7Cz1paGrVoYNxw3//2/yq2PKxqLaqiaocLaUhuUHQEFiHKt0dkVlhqHCo5?=
 =?us-ascii?Q?dfjnfy1F1kSLPjZkRCev0OI5dG8hiZzklcV8Nu0aWD+JPZDxNnJj64g2cu7L?=
 =?us-ascii?Q?wCcN9W/5MTrQk9QtAf3R3aX8PwvuJFxXLGpgZN5BrBbStsoolBGHLZpmCpOa?=
 =?us-ascii?Q?Ih9vqx062/U04JTyQKyK2/ISXtBVy5NxkR3wfbrMX2cZKg3dvvCFIhu8AZmw?=
 =?us-ascii?Q?fKTD/HEHEHKrpfwzw0dZ25H1z7j78deGGmwm4pm/E359Ynomc48TK0HUIyqa?=
 =?us-ascii?Q?cuGl5TM03AxQk+gEOh2S1bgTT/FOEOpYNZu6/RsqSFVn+TPZfHlpwU6AZEa1?=
 =?us-ascii?Q?HEYZd0LnKQOZDe0xob0Y19hEpWPWtaYuP67tOeoaSS/qdZcDJZfVqOzoErnX?=
 =?us-ascii?Q?u6PDsmXaK/RlWkxzELi/3l57kL8mcgH9SIzZ+4BtAC535AXXiAeO3BnfEYzK?=
 =?us-ascii?Q?bU1SVmHkry2wHNFF+LmVg8dAQneqVFc3L/mLU/oBNDTTSo3UWJtuDVNZeGYn?=
 =?us-ascii?Q?azcvHA612fY5P/or0337LQZma+vVwixAF7STUmMEVjryRsN9X5Fx7903dZuT?=
 =?us-ascii?Q?MAOxhI9/Vt6nLmrZY+ZtMynz6XsmOy2dAjqOsWVsmt3r3d/5RzMoBF0TeHuW?=
 =?us-ascii?Q?9TBvUSvy9DK9ya4GXkZuizkQF0nUFiCTC7MCy/hR5fHE8MGOVMDmjm86N0QY?=
 =?us-ascii?Q?pH4O4Ttk6P8oaKbYf5oYxuYSZgn8LvzOp3viR4wQsFapgkkMuq6/pF4ByUd3?=
 =?us-ascii?Q?tWWYc8dEz2LJEiSkH4Zf4fKBcemnPNgKFm+mBWNIRdOhy+Q74jOhsduyIJCH?=
 =?us-ascii?Q?SRyeiZh1a+YhlMAWweJUO6K9d5mu2I/s9thphhd9IGhScOX5uzq8WLb+u5WC?=
 =?us-ascii?Q?A+7+qbut1a6il4Nh6cQQLN7dptjG+g0z6ZBrPvHuO2R0RFLfh4BNlMMngmmL?=
 =?us-ascii?Q?wkd8eSW7XhqK/9eNUhPveLp4BsYxBaw61UkfWhX/A+4zoEvQCWKcs+mFlq4F?=
 =?us-ascii?Q?yHlSDhIaWxLWqI5J5KnOXKR3h9hc3MdqTNLOaPmmLQgW4UUtT0Ot5Lg7kZbo?=
 =?us-ascii?Q?YAHRu7VBl3L+0huPE9aD1XKL1BKpgGQCIWgma8GuJqeQfp3oyZue8pX8smOu?=
 =?us-ascii?Q?VcYNVO+O7DdTqOQnD1mL3F3NeWWOXTP8x1GQF8Mfi2Z49aOJJiu08yghXEGd?=
 =?us-ascii?Q?AhhAFRKx7xEeRiUn5dVj3s8Fj7XH2bd7K7OUTfd8NvDAdX/M3r9G0+ZTw8wd?=
 =?us-ascii?Q?2VgIoGx5eLX0qB/aXgncDEWDkotHdWSiF6VaEFGr5czgr4Zqt6/ic027nykf?=
 =?us-ascii?Q?/JiV4SGJ7MxsJAsY1h7Y3ezc6QX9BoKA5CmtTR7By8plvYUpH9Ui0C9gqKoO?=
 =?us-ascii?Q?8cxkHrUZVK+eAMAR0wk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d915680-0957-4964-6a19-08dd60f0fb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 23:03:47.9617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/c6VwqKWP23wAKWmzloXmBEIC9hrfPLMKk0gLeiZDvk5T+Qvc9BgGQSx2UrsgJ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish K=
asiviswanathan
Sent: Wednesday, March 12, 2025 02:17
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amd/pm: add unique_id for gfx12

Expose unique_id for gfx12

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 1d04f1b79ded..2179344e78d9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2341,6 +2341,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                case IP_VERSION(11, 0, 1):
                case IP_VERSION(11, 0, 2):
                case IP_VERSION(11, 0, 3):
+               case IP_VERSION(12, 0, 0):
+               case IP_VERSION(12, 0, 1):
                        *states =3D ATTR_STATE_SUPPORTED;
                        break;
                default:
--
2.34.1

