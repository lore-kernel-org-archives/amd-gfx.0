Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9853ACDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 07:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 129F810E497;
	Thu, 19 Oct 2023 07:18:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AAE10E497
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 07:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH5sgi76uS2WxrNLibAk4br2m5KtiWYCNm8zlldsuothjgV1TnOOzKKl3cPFEuNUd9nLWcL0t/uHdL2bYN9BdNg4Q09w3Y+1gk4OuDLtDiayJ2hz3RXWt5JegW8OHHg4SLTZUuHIb5+T+FZP8tXpoiqqCX4+FBNLOb4zQ054Zpii7UsA/LHG+WxiFyQKmMUxSGBLkUAFf2uknalSvP/2f9wStPYucsoFi1wi1LSWq7DzKL7O6j3uBwwZCl1IglB+cs0LZuwqBuAwerzx9uwAtI50TQXvyzx92QucDZ/lJ2tghDMlE7EkV3T6EByKak0rwZELQd24bi1ifmApkaGVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4aDg+hVl8XjNDlLbLf2ykWmvNmrDyZ+JRCTtlYff9w=;
 b=YDJG0Q5WFcK86++5z2HmUtR3ETNGJWAIVZawhMyIZ2UDYvjUQmZWhrj3JTiRGF6rJORnxVAqAJdKKRcwFPvgDbV5AL0T109XeuGDEaEgbD5G9zVctr09tiFBM/Kde6OVi+3quAqITRx3NGQNsJsKAtk/AX3n2xSgLlVgBzsZCChZSMVn/kxbZuFE9qdkK2DKxf6JZCgpll3U3xAN3QBqI0UzCrGpt93aAJKKk+kMQimPWFlbnUn3rRbxW5DggrlZ/6O6ztOBb9QSTY+0sbY0y+zZEYzQ3gIyRIIZx96nz/GQrDls8uG2FUd9u7yUD1mKeETjZaA1ft/UkVyov8eRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4aDg+hVl8XjNDlLbLf2ykWmvNmrDyZ+JRCTtlYff9w=;
 b=GAsAwNe2GUTFoJV1ilwn2oFAmbBJny5YvPMall3DnnpbcI7PoOdKAAS7LVhXGCcyE2qf/Zi9fHzNhMI3dEVNpyoratPLEqjh2kGlIVJKYE8spgVFevB/OHcfCqm5lPhz+RI6gzG8Fzq1ULkUrQpAs+Zn2nbN7qzIT19phxIYToQ=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 07:18:39 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::9236:d15e:dad2:96a3]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::9236:d15e:dad2:96a3%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 07:18:39 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix typo for amdgpu ras error data print
Thread-Topic: [PATCH] drm/amdgpu: fix typo for amdgpu ras error data print
Thread-Index: AQHaAlwXvgUha6W/6UmV9GOm32tFF7BQtCcg
Date: Thu, 19 Oct 2023 07:18:39 +0000
Message-ID: <MW4PR12MB6875606793B0394992A2F16691D4A@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20231019071528.982386-1-kevinyang.wang@amd.com>
In-Reply-To: <20231019071528.982386-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=140fa785-6b1d-4f2e-911f-c38b4237fdbc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T07:18:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|MW4PR12MB6874:EE_
x-ms-office365-filtering-correlation-id: 8f83bf34-2531-418c-a91e-08dbd0739de0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73Ryyr3aEIxMiqsMubM1lT1cH7dg61/XVVuOAQJEny4P9EJtPcps6RscQBmpzKe5ZYmuqoHz9cjKO5lPbGCqedm+JF7SDKCKrUaPZD4GdL6mZl7phi5+GTvWYrXm5yxYqBQk1UbFlJAEQK0iuLVhRa1UU8lMv4+qX9FFdz5Z911YQE0IDgtuMbbFrJ1wFjuEbhm/ZqUj/ZzTjqK7Szm1eODrJumUmyHEwPoL5xIW6IkjRFyi0ZfRlfoD2z1UUJiT+tAy9fciR9Bvhl2+CVSz4G/7i+6HKvzXE8GPtH4WGVtwiGNeYY1P6zdGYbzsoMZX5oTFu1D4UYiYeWvWVbA5RHPGfk5OC+khHty/zTvzpbGY/2NuCl+8BWs5ifZ0SKGkjOczkM85kfkhts0iu8ZID923/ze+u1q5Dgs+ZTTlGW7XeNMIQjdh2moksKcow34f8MCT9DsPZ9/VK12YTfsdPvOVuzAOBCNHueV9UJ/i3P658CwnHuGqKsK/zXyNNwr3VInfT1PnIZuNBAPVZuV4su1ZCF3qU0SBh8PqmxzXIhXtQHu3HafGZjtkGOfbMxsgQBe6pbxHZuISSehQ9JhwjlUKMN9jNhm3rhWmORAbHTfpFuvE3gZuPoI6p6tANeYc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(52536014)(41300700001)(4326008)(5660300002)(55016003)(8936002)(8676002)(316002)(53546011)(66946007)(66446008)(66556008)(76116006)(64756008)(66476007)(54906003)(110136005)(478600001)(38100700002)(26005)(33656002)(6506007)(9686003)(83380400001)(7696005)(122000001)(86362001)(38070700005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KMe2jME6rWsSNr8AI9Cs2hT+DDq+Kp65ucOGV44ksJ0RL4kJ0HbznK3Q3Ym8?=
 =?us-ascii?Q?2XtRze7m7LZ3rj/0q9brg9FsWVEX0aILPQrzVC4or5tmVXTdtLrGijKvOhrR?=
 =?us-ascii?Q?Og0LN/XoD0h+pJzkId5ev8EYjCYevRLYAsdzRvhqnC3T8RLDfWv9icL5HiiS?=
 =?us-ascii?Q?hxExPvZZJByjtHOycM42B7vzlS7et9Wxb/oHB4CnMQwzyj9mAYDhfBpo0kmy?=
 =?us-ascii?Q?rTywzyGfNCpl71qv1tsAkx8odaMW1rZ05JsBWAeDEKG6wbPKZ06we3OotUm3?=
 =?us-ascii?Q?4+VX3sHUsOaPpsd6zof6BZ+DSIqvmd0ISgH4DzlxrHwXPASAhgz9K5b9OBqd?=
 =?us-ascii?Q?Gpix5ec0K8Uqdq2105QSMJSpw36AvKLoT0P81kah/7UKqzaj20HpTgYp0VaV?=
 =?us-ascii?Q?v2v/kLKOb9npQUw9DyLRd7jX1J/4fcUP4xTb0qxb+U01dOb/iLS+x5rPSUKC?=
 =?us-ascii?Q?BKWeb+hYSFbKiRxqHstftkMDCl+BvhRsrx1V8DyuLmEfNhnNMpYVtfMn4fwd?=
 =?us-ascii?Q?6QEb0vmR+KrtXOBxnqiqaEuKexpx0KH2wEKboAzEUgtQp72tqHkvprmRi0j4?=
 =?us-ascii?Q?/R9nid2rXmHZDlHw/cXHfzN9dogXJ1+Bdzpq6V/o8whQwcDxeNJ6raQKRw7U?=
 =?us-ascii?Q?cT4HW/ZD99aXb4WhDLMnkaOAThEa6K45Xl2MEV27D6R53bik8rxp5MFO3bKy?=
 =?us-ascii?Q?pAiOSqZHCHQFYcPFnOP7ZQHs61VFWX2prdhiGuMA0FmSSgPzz9Qek686+jMW?=
 =?us-ascii?Q?ziOvHUEBJBU0D9HWj5Wqv/ZrmROkJvjoV2kzr3tH/4jBmnQEAD5dA95M9qDV?=
 =?us-ascii?Q?mWuauapEhLYUAjrPoAMZLB0yCzuv2Xgh55Zt0/xPCMjs8EOAbD2JfDg3xrmo?=
 =?us-ascii?Q?1RC0CzeQhHiHlM+UFRcfriwUm9n29IGru2zYfxnLN9z/5ANnVnp1LLVfyOtV?=
 =?us-ascii?Q?VSfR+j4ytd6jR7i+wkB/CLHEXl07TEq4/OH8K2grZRPKNXSgxApdnMjiDNrT?=
 =?us-ascii?Q?kkRb8ELqsJhS8iSAAAQ5P/2TVwEzLadAhZupL/2JfjFGIjCNL1zd2qbgTuNd?=
 =?us-ascii?Q?c1C6A3e1py2p4HB/WfGsROwT/EQFbzGKRt+x3I8zyIYDzyzvxtsAnaLBXipf?=
 =?us-ascii?Q?lXtBeiuagtmAB/asiCjJYGsiC0VaAo9HI3OG8ebMLT8KezeaLw0ZF3QsLZNu?=
 =?us-ascii?Q?HrDWK/F2tQuuGApmnygehvpNwUybcX0MaeUyZMAhfLePi6iQKvP64ktLCbbI?=
 =?us-ascii?Q?5wan1E7rlgYNb69eGLwOd/D5QN0qWouhk1L6teFpkgAY7bEqcuq0sMrzmTwN?=
 =?us-ascii?Q?MlRWawMwdRoO8g/DVTXFXwZhr0KcakLoSx9eTRPBtrhhfK+nGwh6SdDxiqFT?=
 =?us-ascii?Q?mdP4LoC/z8BTFRVa4z2uv68bsOsdJjst80yXPlWkPfulmHfeJghf33chMZVi?=
 =?us-ascii?Q?+AqKBnA9CzK6LGawingIu9pA7eyixjlCpkO6oSuFpURs8apixHCIfekd5c1A?=
 =?us-ascii?Q?942mj34T2sAT0H4sJvvnm9H8iZJrNwbEWeNI5e7pHNHX6KzXGIlt2RN3nBmw?=
 =?us-ascii?Q?Fb20CkHZL32pq402s7A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f83bf34-2531-418c-a91e-08dbd0739de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 07:18:39.1175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4YLIyR5BF+82JuK5CfGoWfumtjpT5FBaaW2jIcIsBsdxoztKfSFaDsKB50waXzF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Candice Li <candice.li@amd.com>



Thanks,
Candice

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Thursday, October 19, 2023 3:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhang, Hawking <Hawking.Zha=
ng@amd.com>
Subject: [PATCH] drm/amdgpu: fix typo for amdgpu ras error data print

typo fix.

Fixes: d479ef0d5fbd ("drm/amdgpu: add ras_err_info to identify RAS error so=
urce")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index c7f8dcb3b4d2..5b831ba0ebb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1038,7 +1038,7 @@ static void amdgpu_ras_error_print_error_data(struct =
amdgpu_device *adev,
                         ras_mgr->err_data.ue_count, blk_name);
        else
                dev_info(adev->dev, "%ld correctable hardware errors detect=
ed in %s block\n",
-                        ras_mgr->err_data.ue_count, blk_name);
+                        ras_mgr->err_data.ce_count, blk_name);

        for_each_ras_error(err_node, err_data) {
                err_info =3D &err_node->err_info;
@@ -1055,7 +1055,7 @@ static void amdgpu_ras_error_print_error_data(struct =
amdgpu_device *adev,
                                 "%lld correctable hardware errors detected=
 in %s block\n",
                                 mcm_info->socket_id,
                                 mcm_info->die_id,
-                                err_info->ue_count,
+                                err_info->ce_count,
                                 blk_name);
                }
        }
--
2.34.1

