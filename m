Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8521DEB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 04:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D261810E27F;
	Tue, 27 Jun 2023 04:06:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB9310E27F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 04:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=manwFpFIIe1O3mMAxUsuQSDfR/18mUkyr6j/oIqIOMy8ZxJQItlsFujFWHzI72EfgfWitIrF8hnaybVJnWh1PuGQqP2aA6GB37fRk9QoFkrnogTLGhaqaF/OAe2MInZ28KTCIZ4RU2cwj1kUGNLoVbezX0UL3RI0WP2A8fCimCXHhz6BVvwK9RmswQsefPhm/0yyDQP9t0lOCn7Apx2ARCDshpg6nQfvVAofK8WmsNhOWdZtmCe/+eUf9FGPFBKQOu1dpG7ho7opfpaujn8ChcNiCXsTgnDa9VPtr18Oz2d7i1cr3eHBarCE2lMdtVGx+fv8hm2mcKYWbB91F70bGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnEM4V9/Ny9JEU5JWKxtaX3uwW+2VbwKtoO3knLvlKQ=;
 b=gDBZG1r8EDepFjdGO2kkgXCkzffaHk0DcJKRTaLbjWWec60hEElbIzTJxxC+wnJAzPRYlwmSrQeJGdkU6q6OuZxlEMfEjckDJdxSJ+Lo3lHT/U8U72LOioDJ2MvkIUJUfbggZrJPRIqpGSfukJRzeHTSwwkZqwGGfy6769fIA3RLiHTNZKtN1u9AjO1q95iGa3g9CUld6Z1oxPbJwynCNjFkD1q/uaZLPkfNAzIHQ99r9Ufd2Z3PcTT7R66LXkCDgO3+EejzS3FTHffPs+QjJgqMpry2/1nyCrwtEYPQLyMCwppJgazFxltwiX1xS7Q95s8KEQ0VnLmIiicUBIB5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnEM4V9/Ny9JEU5JWKxtaX3uwW+2VbwKtoO3knLvlKQ=;
 b=v40eaT5G2Qd6aMIZuOjtGSkpvayjww1L3ka9DVhebLM1T7PrkZmXAQT1x8y7gtsgaolDV+nVcDAJHMmvuC9HAgL+SEQZiSAx7VkPE29xENIebn0O8zRobX4NxB2R0+82HajW38W4cTsLaV+WkqSClIJEp24Nh+PMxTU4cvIseqw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 04:06:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 04:06:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: remove duplicated doorbell range init for
 sdma v4.4.2
Thread-Topic: [PATCH 1/1] drm/amdgpu: remove duplicated doorbell range init
 for sdma v4.4.2
Thread-Index: AQHZqKtiOYU5jdns0UCbECoMHOCQv6+eB7bA
Date: Tue, 27 Jun 2023 04:06:51 +0000
Message-ID: <BN9PR12MB5257E40DCB53179645A5E283FC27A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230627035620.8589-1-le.ma@amd.com>
In-Reply-To: <20230627035620.8589-1-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=464d2982-4c7c-4e50-adba-119c67545ec8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-27T04:04:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB7638:EE_
x-ms-office365-filtering-correlation-id: 9f6295e5-1a17-4e51-2922-08db76c3ef8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d8Vni3vIQIU4SEJvNCeORd+r8je7eli6+/+YUUGQCdXfvZIMuHwTUQjsuP1KizBGkREdD9M+D0/1OUoMG7B90i1FlAa5XPJi9gMQkKxsaY4bjlmBktuen645S8skGCsUa47CsALHrw4IYibgxv90M1OyZLfJGEZm7r839t0bdg4SGf2TT28NJ7NQUbUjLFaEFj6taFK6FHbYOxbZOx5DMe/fINeIyog2vFF51H0GRxBS1WaTF3vmoZqTfBYl7dMfljnezjXfkKhNvZGd4XeT0Wjn6OV8/Vxwv8ig8hkkZMEf0Pg7wwl3o01Gd4VX/f07xk5/MJLAqAl9N+lq+OuYF8En0IUcjrp88pw+/cFidfSDa7YzUgEh+/iiBUc9kWEf1s+v0feJkEm+/tj4aSh1U3qfMkDCtSJHd+ONjP8XnDPrePl9eFuee/2MhZgYD0uOOx3ZkIbVopTneJq6itSJJbVokeurcL9bHWbwSLxv1SKFjJSAupcMq4HckzqpymEZcNV1ga+KYprpCog8VVGTNT2KYRzrm2rPzPMHfHdEyKSA8tqHKMRWidVNJOYq0d+d9cfarbmsActoe8TcKfh51DcOhqshQzz75uKsW2k79SQ4kRcZEb1miFwvW+1jKo4c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(26005)(33656002)(5660300002)(52536014)(66446008)(66946007)(41300700001)(8936002)(66556008)(64756008)(38070700005)(66476007)(86362001)(38100700002)(122000001)(76116006)(316002)(8676002)(55016003)(9686003)(2906002)(6506007)(53546011)(186003)(7696005)(478600001)(83380400001)(71200400001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aiubK2CALo/Ms8dJCU4HpoUZiabVukQrjOHe7vlHSMZ4H9ETrGfP0qAjefNO?=
 =?us-ascii?Q?rsEeMkUpk3Jt698bj57VQOBmMPv0rKrhtNWzY4dWdDbteJq54Tmzsb7Z9NL4?=
 =?us-ascii?Q?C5IwGkj79FQA867hL+LwoUi+lnNKTwPQvdPqPnLLE4QfrMUmu9x7nGYqPVTs?=
 =?us-ascii?Q?G1q2bwKQtbsSEqfAEzKiHsdl155Bl2EnJqpTf/4M7Vqni4S/Rvzj5NFzaDuM?=
 =?us-ascii?Q?LGckUW1EiptAGqvZ0NBpC2v44bdA/Xo9GtwXdkI/wvDELCKA0Xb3y0JXIaqE?=
 =?us-ascii?Q?YGtRlaxTtB7KNR4omNC+6HdRqqcWMjuKUkJ32Y3qUoJV+Be+qkP8CEMYqAhA?=
 =?us-ascii?Q?kVkGKYypGxHd0zHfsWhSgHkMiVOgIZZfEZh8NaMrNJs/7O92mx2baHqXG4fM?=
 =?us-ascii?Q?rAb2CQPRSVomdLdKyczkWP4IGC8y0g0UvREhAkGnasaRR7wKBxP7TDn+OhZt?=
 =?us-ascii?Q?zPHWSsfCvS6LjBxvgn+//yP4sLkdKEGc/zEpI0h77HhJ9v/uH0vBkmv1QuuP?=
 =?us-ascii?Q?fJbgA2OUl+e5naa1TqKcWVyxmK5wiRm5YADEz7wXzVbRCui0PR9Wba/+R2aI?=
 =?us-ascii?Q?xylESOKhLshQO6MtBGXAfAIyXDlY59ATXNYOAKvSUi/YK7VorMLUJBzpyNT+?=
 =?us-ascii?Q?6tLqhoNbckC/+anmNtb5GovSb3zCn1+SmD/HJeqmZj7ahl6Zadww9VzDUZlr?=
 =?us-ascii?Q?wCIZfBsPVj+AwT37832VGB03xQIJLfkhA/Q9Y0kWJ4UDtXlQLyTr3BkbKwbO?=
 =?us-ascii?Q?He/9Q6oqJSht8x4ohmIpW5IjZ6bGuWVJlCjCyZVmy6ZZbO7uwL9FHXxtnnBX?=
 =?us-ascii?Q?0HjYhpE3gk3tcXg8DJNEBaQ2itW6A4QgBXoJGIQVwy92Dvxeqt7N38GJOugl?=
 =?us-ascii?Q?LplkCFkHQiuq5lLxHDJ87CoIKjJpCKiB8uprTnYZsM2WHi8VCtqWxLXuXrKF?=
 =?us-ascii?Q?0rPR0mrQCG9+0qnpMV68z2xTd/bqL1aWTsbO4suyd5a+QjjHpbEVXzL4Dthd?=
 =?us-ascii?Q?s+H2oUgCLmCOiLH2UkGgaWMp0raArxrtW4QDQvv6EvXYNpuU9BUQyy13NP7l?=
 =?us-ascii?Q?NQsBcsTe5XVKCER5c745Mzek+63ujiygrfEox37dVnajxNR794KllmhUJvP2?=
 =?us-ascii?Q?ZhjhcD9IASZN2OudU70ZBpFA7XRd7ZWZb7DuzHmIjPD6I/meMcKM13O+klXW?=
 =?us-ascii?Q?ExqArhosF5cVb17tRsmNKKn8/dZP3oRvQ8+D/WxUCHTGxd0ukL9BTZtFryev?=
 =?us-ascii?Q?xHtUczKB+hennqpdpTPx40hR6+ZPm+OHgUmfnqwbtRgdwM1qu/SBq7uuTQzF?=
 =?us-ascii?Q?8zKkJDG9iy8I47goio/DJDJkn688S/nqBRvZCw7dEEwITsT6xiE04uRSUIR8?=
 =?us-ascii?Q?Wi4Dm55/SjRIZ3JeDLJY2RgL6RZDKRVL2RlNozEPOEybZg3IUdJ73Aldtn/4?=
 =?us-ascii?Q?4rhZjt7Y3g9U8iYHHMkT3Hvdk7hh0W0CWdpi5caWQ8KwgKyhEPGSj7+5dOAB?=
 =?us-ascii?Q?xCO/GTmnpPNq+zwOUfC9zxokRYs/dCrf6ZRRd3dTO/bYPAncqI56gescz13L?=
 =?us-ascii?Q?/76b1+cgMT+9H1sA+tU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6295e5-1a17-4e51-2922-08db76c3ef8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 04:06:51.2476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSUYgQmY+mX+JfqWa/UxsVXvrUe1Xbzy9bYX6PVZ22EvsMUSQo95n3xf8ovpUTvJrLks2AvzIsclNoQyua80DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Le Ma
Sent: Tuesday, June 27, 2023 11:56
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: remove duplicated doorbell range init for =
sdma v4.4.2

Handled in earlier phase

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 6be19ffc502b..f413898dda37 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -902,11 +902,6 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device=
 *adev,
                WREG32_SDMA(i, regSDMA_CNTL, temp);

                if (!amdgpu_sriov_vf(adev)) {
-                       ring =3D &adev->sdma.instance[i].ring;
-                       adev->nbio.funcs->sdma_doorbell_range(adev, i,
-                               ring->use_doorbell, ring->doorbell_index,
-                               adev->doorbell_index.sdma_doorbell_range);
-
                        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PS=
P) {
                                /* unhalt engine */
                                temp =3D RREG32_SDMA(i, regSDMA_F32_CNTL);
--
2.38.1

