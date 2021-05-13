Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB70EC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 11:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B0F611BE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 11:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B0F611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659F86ECEA;
	Thu, 13 May 2021 11:00:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46A56ECEA
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 11:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Szt9Ki9xwPIOjaM+PIX8uAtToI2oQ9vCK0HqOlYL+C1fFR61EtwEZ3KzmHBfICXDKlEd/G4qvAMvtqX2Nh18lxHAJkPSYpO7JtIyLtwd9RhWqV4pir8zvNw6KVbvbsmZYrdknvsgGafNrA1FMOjzDmL1I70q4dlJyd3hqQ4mOYs+gUtDj7rX8aoiYWNHYe5WUrbHK4ycV2IFJr2eqgDIxqH5/XSk3Fz83oVXp+4/ahVBQyGuub4Z+DaseBoeoyxS6Cwyr63dEbubKpzSVFN8c5Nn8ssV5fQy7JgiLeMDQSJakulGja2oXini6zFMGiJ2CCR/qBqunC1ktmawz+c79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV3ZNuq3h1YKJzV80qSki4jbLuFLamRuQiS4AdsQtDg=;
 b=ch4mZ2Zwssyhcj85Rwhlv+6cxkd+vmFc5IxExwvPyeKjLjGGZ9aCDDLgM3mqY9odG5V+7DKyjzLK48Znvhy1e5WUboms3100FE4I77HrTHyuUWoil6SVbNKYhJHgh+nklcsL+cA03nK9tBGV0FK0AonP/0nU2zs+E5j7WGN+OCfa+VnR9sAGixQJAiJw3U9dl3zb4qBr0PbRRqx6VO7SsWecwoBPBgyuxn4j1HYvviA8UGrjC24OXn+X3SHa9erwKZntfBaG3wcugTCzTCEOMZcO6E1cb8VSA9hyayMh08OCdG7TrbdltYQVBE+QaTbqw+uEqvbAiC0ulKvxoaDUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV3ZNuq3h1YKJzV80qSki4jbLuFLamRuQiS4AdsQtDg=;
 b=2kuAkPXptSQih/pyAqgFaBh24iimH6GuQZPIw0By2KEcU8wCqqfUvIQL5hIdAGvXByx9FgRE579RJ2O7Pq1yLZ5N+gc9+HUeWt2hWJk8wtNAxsYmKvQg1tHaoropbthOJwUu8UPDHKL+DXkQ8aKzbEPtD29s+sjGn6zmQyuDV6Y=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 11:00:46 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 11:00:46 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Nieto, David M" <David.Nieto@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Thread-Topic: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Thread-Index: AQHXR8L16W5YG33TlkyouVsmvlLg0arhPsmw
Date: Thu, 13 May 2021 11:00:45 +0000
Message-ID: <CH0PR12MB51566C4310A9E3644BCAA9E0F8519@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210513064051.12930-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210513064051.12930-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T11:00:39Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=65b63341-80d1-48f0-ba53-eb2bfcd9aa77;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1878a198-4744-4715-b3a7-08d915fe5c15
x-ms-traffictypediagnostic: CH0PR12MB5348:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB534817562E33BAEE4B042F4FF8519@CH0PR12MB5348.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wd/DEOwgkulJZTy5UWyXK94rq4YCvg3x9vvwcmUCJwq3nihkDLf8ig7nXeT5CHHq1bF/UESFmGNIsWoMuzs8o1Y2cb0+hTWjX4NPREB9XxZU6dqfCRQLlaM+WFb3KeENTu+vxljWCsLwMFG4PUEUkMOUvmLV4yWIqQnP7DmmLGSj4O1zm+M3ij6RLR1u8jNndIF0pzm4EBe0q58G2NCi7NAyj71zkhNuogShKt3jTxYyVv6Ky7SETFRxSB2eht78l68J+5VuN92vEf6TmQXOHU0qtG+LJJQre8opLsr+10OdOc4Jzcs9CKkiT9nIFg25lFV717mXd9eDMtRUbyJwSbeu9+ayNjzAFS6m01vgtASQzP2LexyNTXLSB6s1ja3ARhL8PNO2qt+PhgI/7GGr4jNHH9JsWDTyfa8MtK53Oq87ZixcN2ft2Eevr9s0nHbifp/QTjxzOO1aa7qgEvywU7bvbcYTwvM95aZnOMninlG3pCifD3HfGmEp2JhS1IfrijKpS8zLhh5WqvGYgt1HBTct4BHI7k0Fix5a765yS6vbtB9JU8BJRvC7Gu+Ki4ZJ29jWIZZGUBiJFjvUKwpx50scpTEnA3NwXejpjQI+l6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(86362001)(4326008)(122000001)(38100700002)(66946007)(316002)(64756008)(71200400001)(83380400001)(2906002)(33656002)(52536014)(7696005)(110136005)(186003)(8936002)(6636002)(8676002)(53546011)(6506007)(478600001)(5660300002)(76116006)(55016002)(9686003)(66476007)(66446008)(26005)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uyGOwAupiBo4HFpk75SPyPn7CbJpkbr7ShF4KoY8hKBfUhZttPa8fo+nF8XK?=
 =?us-ascii?Q?BUGpJ9SQ5CepWssuw3t3pzYAjI159+zg6onzNnTiUK6EANYbtVkISZfGU0f8?=
 =?us-ascii?Q?/5CuQe+e99LqrcxHBJPzdJsP9hsmXwXYpaFwXzte5f8Z55KnOoR+o/3N7Ufx?=
 =?us-ascii?Q?jHbenjRTV02yc28LtPUzET/4tdpx8nr8NDMbcD3V+ELTcPXCgMBsuRDrWKrS?=
 =?us-ascii?Q?heanEMrwKyn+mb5Of6X70AQti+O4Lw1uVdj6UB6rWjsJJJvp9aZOmzdetl/6?=
 =?us-ascii?Q?uF56LmKqdpVTWJ7j6PHbdKZEqrriSK88JTWQ603KEPKmFkHM0tDM9FcwbCJk?=
 =?us-ascii?Q?/Q56CaEZmXDFluLyo7f3h4Dbp1WKDvUfT3HbOEXLKvmVJovvwP/RSrHqHpVl?=
 =?us-ascii?Q?wrRbHkaQ8kjvYDCR8j9vJKRmfbSWOZhkl82r3FdOu8xY5FhvsRwgEwWl3dck?=
 =?us-ascii?Q?fLSb+imB2loc5MTxt/Nsd8zPlq6p2f3srT3CZla/xnbM2teVQqxFAvkBIIHh?=
 =?us-ascii?Q?fs/bAuTjldwq5MFYCgXSivkWvcXSpD0Cv8WtjNfwKbc5mmgv0LYLZbHEBifU?=
 =?us-ascii?Q?2wfSAAS6KGuNiv8M1mvJTUOfeL+1Ok0vZwgFMB4Utn91okJ974sLMdbieJ9h?=
 =?us-ascii?Q?UHELOQls+DdDU16uZ/yYRRulbEhqPKFs7LFDEeKiKZTzjRm1ZtKr9Oqyfrw+?=
 =?us-ascii?Q?ft2uqjObIsnpaLgukXxa6XR6LNnEnfcddUDf0TuEF0zUEIwPZbdQE3pFiwGn?=
 =?us-ascii?Q?W/Hq32xFBDFDXhJjRJCRg7x0nL4sgC/alnMu4rX//9FdmBosEUCmcIXiSmtC?=
 =?us-ascii?Q?PelfnLXVIhWrHGQHoah8a2QAPaQMljlHQbrArRwdbbzaj3kFVf1eV4JZEvSd?=
 =?us-ascii?Q?tLli4U3jTvPDInFGv+FRAfZiBDvXJS7KtnRhSGozIDjXj88bT43D752VU+As?=
 =?us-ascii?Q?llSlJUwnekxlXSWjn7GTUBv+yvrmfmGhZRfh9K1CgWZ5Qe2CHxg+i2gbrXkl?=
 =?us-ascii?Q?yRc5QjK0ADM6O+oi/vlB4wcFRsX4vX9CHHYZtfoEPC/hlw/ZnUCvQbynAxee?=
 =?us-ascii?Q?dZVXpehnL6FuJLqkwrbJuo+ro5mDX3Er8JVddNzzKKLUDZzfzSVUS6NWMAOD?=
 =?us-ascii?Q?Q0jnYvVgHPON6ULXzYCkaYeN+jaHgK1Z/4JZMSblpynmEjWkdK95CwsTLb1Q?=
 =?us-ascii?Q?x+u1oUm95IReD2fX7AF2SuR+MTjdLS5vmHa+pvQvUImHgY1Z4Omzw/lnahWX?=
 =?us-ascii?Q?HuUs3KHW6vA1nROtibqAHksgP4sRxEzq+sIWbmy3c0QO/3NETMcwCt+ahaY/?=
 =?us-ascii?Q?rS5K+exF4rCrYawXe+7mwWut?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1878a198-4744-4715-b3a7-08d915fe5c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 11:00:45.8327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1F+n3jATHkJucneGS94MKvZXacvKmk7FcCvtBFP4YCVIni4tOadhmdxL5QNMJw+inUl1zcsllFQ18EKTn2WTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5348
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Add David.

-----Original Message-----
From: Jiawei Gu <Jiawei.Gu@amd.com> 
Sent: Thursday, May 13, 2021 2:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg

Initialize unique_id from PF2VF under virtualization.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a57842689d42..96e269cbe326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -471,6 +471,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
 		adev->virt.reg_access =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->reg_access_flags.all;
+		adev->unique_id =
+			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
 
 		break;
 	default:
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
