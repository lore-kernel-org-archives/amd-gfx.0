Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555B5EB64DB
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 13:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D5610E201;
	Mon, 19 Jun 2023 13:27:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2359F10E202
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 13:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYj844fvQBSTlbAKK6EJafW2fwvDbUTN2su6iyA4neUbrlM/x8E56qYN2zSDduWeUZ3ZCnB7eLWksJIicqnPg7qV0Yx8a2Ume3QSZ+0hD4RdopWBA2rtpOYW1aoOl4HgndBcUPGqAXodn2zgU8KgCEv9wYvEZHMnIUsTtkWxiipumIf4LwImV15ukz4i9ly+ptn/KlwzzmTcNiJcX9NJXrVw2oEHWw34PExCNbLGDWry+uA3C6XxqW+nisAmJ33PiQjsqWyLHiaCRHST5kHaxTDErY1uZVWBqejuhuzWIs4o0gSRd7ApUf8wIVlXCRtvBBvdd6cgVTqeOC2yi4GMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN3qcZxNKsFjct7o6y5vzw5dHA8ofSw6FIbyJzMcBr0=;
 b=Y1mV/vZJmttvDqz2lr7o90EqXHnRKlIPmEUxalpCCusExCASTSmLZfZtImW+zBH9KeA1qxqREu23RMX6fHAwhOLLvg8/+G3umq0iJhiIf6GuzAKRQ7MWd/wQKdV9TYo673iT3jI3e7bQow/cPQHLJyLoUDV1rmMYZT7M3VcvjFPzZaok7AHe6z49Gf4Y7Xr28OBnJHQXQNdmlkQRHwh/hgCth9cGTrQMzORLfec3iLPHvOqafhUNuN79mAQovw5NTDgHInVuhY5FSChvHdTOr2BAjUZIjvD9Kg1J72Ymn2SFqocMaW47kbJOcNW0BmkyF8LeGgj0oIH1nZ2Fha9E1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN3qcZxNKsFjct7o6y5vzw5dHA8ofSw6FIbyJzMcBr0=;
 b=vT1I59+IgeVeBnMea5zFVsP5ED3a/R2j20bFKT0vu1REIITwxrPbDVOm3vCkqoQV00ugmklRueQqnB/41kLc3gcC+buVVwy6sMyTNGLvGF3pBcbM+2izd/UKBof5Vexf4ijrAAx24kwnRF3wk7WJzyDziT1eD6wb3ID6e8Mk03Y=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Mon, 19 Jun 2023 13:27:17 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 13:27:17 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn: Need to pause dpg before stop dpg
Thread-Topic: [PATCH] drm/amdgpu/vcn: Need to pause dpg before stop dpg
Thread-Index: AQHZopgk1EgsFHby3kSkmpmEgbDcn6+SG/0w
Date: Mon, 19 Jun 2023 13:27:17 +0000
Message-ID: <DM8PR12MB539986B2B0C864DF21C83C1BE55FA@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20230619102334.2264865-1-Emily.Deng@amd.com>
In-Reply-To: <20230619102334.2264865-1-Emily.Deng@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ec4964b7-f4f2-408c-a4c0-6d9b24c6fbe3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-19T13:18:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SA1PR12MB5672:EE_
x-ms-office365-filtering-correlation-id: ec3ed9de-3557-4d15-ca13-08db70c8e6dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zjee/Qh8M/pm/VzNSWMrp18OOJgy9Ma4UbjDOCsZJ+mKhQE+acYjFCaZJFa5I+FMWM8ZHWBqeseN5Y5FhFV0ZYacNHMRtrrNgBFADR7FOn6RFBXsV2xCcNguoWYjX4c3OYv7jJ+FrKcawr9cDatXyn4hN6tAPO4r6cw/j2WHKSbOwvrcpYdd2GI1SObwxr/9ShtFKIAAMDtoP+zARpcxLeMpeIWyGOMkYHNr94vxMx0yxNCrSCptUepbQroAEXAxelXYNQMCb4Ho+d95wL94yvum+jNHM7I+SYs/SvBfPCEIWg12ZatJJSFfVSDUclQtIScTXZAgL1dO+Yk3JapZ3D8CDT8WMceqj9046aHFCTT7RnPufo4VrA21Wtfw+0xUZyXhhXPhFYePuuafl7GqPJmHrWKB6QFtYpaVw/DtcmWMNLHV/gHOE8qoQCr04uHSQAvKNqc6//DZi5S7hv6V0ciNSk9RJvjlKgt8KLDeU2So8TZjSuRgerD91dSpoTV7kC9bNlQRggdVFR7eLq/TUKOvRVT9lbG19NGYIuaStT3qt2sSzf9cPtAoxnzyfcdZIthqqFMC1nCtROujbKQBElXoJkJtelR3mUDQ/VenyxKQlbA7SHWHsD/JYqv1Fhte
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(478600001)(2906002)(7696005)(55016003)(110136005)(86362001)(33656002)(71200400001)(122000001)(38070700005)(9686003)(26005)(186003)(6506007)(53546011)(8936002)(8676002)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(5660300002)(38100700002)(52536014)(316002)(4326008)(83380400001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8RzxDcBdJf3nAIAJz5q4VvlGCpYp5YeP6B2xWqU8XGpsVMj1BuS5d7RSOsZQ?=
 =?us-ascii?Q?DR5GGLJZokIMgNLCmRvb/hCIAgGRaBLBQ1eSEMzfrTzG9lalRutw4ZyexbJ4?=
 =?us-ascii?Q?wkbfsN2+c+BaGHU0kTFyWMuMmRTVqzsjOmPwLGPlmjvMhsIB3g4pGEZtCTQH?=
 =?us-ascii?Q?88F/li8agEbYIE1IZtRiv9OEzl0i5Dqljrd+Vx9ElY88mqj4uo6lbDY7GcN1?=
 =?us-ascii?Q?rrQt6rTpB21z9I5Q6Z+8k2WwCcVfzbxErzmgdVOF+hHe72ynOgSxQjXHDgPB?=
 =?us-ascii?Q?N9xx+qRooYF1Jn8x5IJ/29fYBDA3IiMHncK5OljRVqgaaQYz4kgoBHvkyWRh?=
 =?us-ascii?Q?Vof3qzW3+Bneu87sFVb7vsIybtZZMnfyO/EecBkGNdvSpymvVexDJImLQQHp?=
 =?us-ascii?Q?9GChXl9qsgKUJJemM9wryq0ksstljqb4YBvSSg9QcVGK3X6XXj6G/gr4Y0iP?=
 =?us-ascii?Q?snFo3DyPuSQf8BJS1uAxZSU+Icihc1HZ63VSbfePny0WCTzYBsecy7j9RsU4?=
 =?us-ascii?Q?cWlM/aJtUD0X6gC10/sKRm1C6VF0FmorWSJIpGz+Otcn0hreQHr9R9moHWyN?=
 =?us-ascii?Q?yeQL2+QVVD/sV4pCpigOG2hSRCSaQ8yKCzMGgsLlzIGRhM/8m2DvgUp4nnM4?=
 =?us-ascii?Q?6gcnrfZ8whvDIlkARyJhMLcqpnrDRw96aOJUFc1yr+jdGFV7vLINHeZZz/CU?=
 =?us-ascii?Q?OtG6Lg4UoKh/JGxWFCBkOuQ4O8Y4+sjOWjKwT3VMZ+F75FeVtclRLVuiWUHZ?=
 =?us-ascii?Q?SAXrS8EL1YTHTlFf1cW9Q3m3JQwCGfAjb4CfxoBsL3SBPOwdWNsESon3jgf/?=
 =?us-ascii?Q?qZJYjAs79bA7BysrWgPJj+cj/eGBxuDg+suL6gqrVDHoemewFyVXoVqjk3GK?=
 =?us-ascii?Q?WWcC+YEJo816py1lt/6baIVbahmqTpk/66qwzbM8rtGiSRFCxEhUtkWC2ZWu?=
 =?us-ascii?Q?Zjif2nPYBaXooou0g8H5sx+aFyemne43JRdw/4P0ayj3wQU9GjFIK/mD/UUr?=
 =?us-ascii?Q?5OHTVYbv8bbtNiRh4zMgNLsvwWfd9D1n4UQ4kHmASNbtiXwMF9fhtrMHulgb?=
 =?us-ascii?Q?/YTJxjKx8LbFQ2xmbUOY3LR3u/7ohc7t0jALQjWxAcj16Ue4RxW6ScamoyOg?=
 =?us-ascii?Q?x0pXeeAFhA7W8AXDwsd7ivkxAf3qA8tpLS5t9DjyqkZz9bj/wTSyKcxY115l?=
 =?us-ascii?Q?/gqJeg8Tp/mUtX4VXy/LbeEHkllCwAYug7+ogFNG+AyAZ+zS+MHs0yl+JdJh?=
 =?us-ascii?Q?yyhGaqdFRIrQS4e3iwwv9LDsLg35zt5TTYElNKTcogalOUeVNkMbgdiAjrU3?=
 =?us-ascii?Q?WOKPNLyTn/16r2md4HrnDIMJTpwosyeCeoaapQlGvRXxvXfPt/+NsFb5c6tf?=
 =?us-ascii?Q?0fgtUH5DcHPXYqY0kwZZ9naA7R09L9R67zeUgcfelfMAAKm0Krnd5zWxxqER?=
 =?us-ascii?Q?NiMIC/0U+uN/o2m3wES4O1izCVQRrdCKXTSD5jj3UiBAtGDXtjyw+d3DkqG4?=
 =?us-ascii?Q?O4tzxbkozt+3+nimqOZM4o39PpRcCKiay5m/3MnTnM1RFwZxwEcIx/Azl1B7?=
 =?us-ascii?Q?NC0VUB/tMw2UWLzb5rM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3ed9de-3557-4d15-ca13-08db70c8e6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 13:27:17.1850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2e97I2VXUa/x82+eFLaBewYZdW6qh/6tIpxtV59W5BSF16lanWZT8x+fJ8fdv0P8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Emily,

Do you want to pause or un-pause dpg mode based on and change and commit me=
ssage?

With bare metal, before calling the stop, the state of dpg should be un-pau=
sed within the call the of amdgpu_vcn_idle_work_handler, is it not the case=
 for SRIOV?

Regards,
Leo


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily De=
ng
Sent: Monday, June 19, 2023 6:24 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: Need to pause dpg before stop dpg

Need to pause dpg first, or it will hit follow error during stop dpg:
"[drm] Register(1) [regUVD_POWER_STATUS] failed to reach value 0x00000001 !=
=3D 0x00000000n"

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index b48bb5212488..259795098173 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1424,8 +1424,10 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device=
 *adev)
  */
 static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_id=
x)  {
+       struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UNPA=
USE};
        uint32_t tmp;

+       vcn_v4_0_pause_dpg_mode(adev, inst_idx, &state);
        /* Wait for power status to be 1 */
        SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
--
2.36.1

