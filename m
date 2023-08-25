Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D15C71133
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 07:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A4010E621;
	Fri, 25 Aug 2023 07:27:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B08410E61F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 07:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZu1eUViSPNH7srOXuLM7J+2+UrcAcyE/fH6e9EJmaRh5LdBy8ah1iXslznFriXFZ9j/6qGTpVwbXShjSdusOwNq8cCYIyMllTuvR0uINl2mqlR3nz8XqWLcEKvmsgA14mLvf2YgbURRESqGr0yJWGU+d2O5/DRA9xsTeYvmI/gCs7XhtykTM7iOma/0atSf6TlUm+cyiiU77rQDNxgrQdRIRuqcNlHdf7+zkYqHmWzRS3qk++/Os8sOsGodyymH6s760i7hmbVBumJb49lSJZZRUpx1k4/km4nSE09CrucAnKiynI+bYVmDaPoNyrLRmZ6Yu7rFwYeC1jWevCQ1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVQdznTnvSaeJXk7fEZ4sik9TBVnT0Dou1vtjqHAxeo=;
 b=KW6LdS2CY0lfz03IkJqxwkarMKiznk6pVGfeTu40yVD5zwA0WiK454gURw4Wu1H15jZJFENOCoIx6+BeTRfXruon+0iBhLRlUtLDA/qXekOvSOv1Nh445b7LcvjPhdm0fTcyklud6EIvTj9GZckVAWI+lX3YCNZOfm242+xSFs2hLsXysNDFT2QQaCRCqMuF8COid+ieuIMqAGCg85NkBxYnppqqJNUpIgB0NGtzMftEfTR/xh+j5+IXk2CBqLcle6VdXbVdFOd3v2n5Jer7IbTf+GGJ3RzgAKtklzj22sE1/TsF5pCOv+pn1Vn+l3TSJbr9IV/LfR2/qQkrqO4Vng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVQdznTnvSaeJXk7fEZ4sik9TBVnT0Dou1vtjqHAxeo=;
 b=nlk2KXZhaJXOH2ePOklWph+IpmN2HL8Yyn2NZzKGTf3aiHzJEuM7fv6fiC35D9Aqcy3/Z+BNep6vvxLfP4HZFGbwSsu6Whp3ayeRSK541/TCoLYBkT7K31V6JON5Hfk/uFEhStN+50kI0v16TVhjlTx+ieUfw3vvrMqYKC9QJBU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 07:27:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 07:27:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use read-modify-write mode for gfx v9_4_3 SQ
 setting
Thread-Topic: [PATCH] drm/amdgpu: use read-modify-write mode for gfx v9_4_3 SQ
 setting
Thread-Index: AQHZ1yUssg4j7MymWEKE3D5oaT9qBK/6nMUw
Date: Fri, 25 Aug 2023 07:27:21 +0000
Message-ID: <BN9PR12MB5257711DB95EC146A63B6CD6FCE3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230825072347.16258-1-tao.zhou1@amd.com>
In-Reply-To: <20230825072347.16258-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8d0781be-7c5d-4c8c-ad27-ec9740973cbd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-25T07:26:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6446:EE_
x-ms-office365-filtering-correlation-id: 0e206b56-a916-42b4-cc14-08dba53cb83c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khsZ4YHXG1GJBZNdI1EYbDY/aBzfQFxzoxoT+e8afkuST4mGrKI+FxsqZKzQ/7av4w0v7/lscptr7RuQu+UtrEtM2hPSTVONNDfs4EZa0P/tDaquGxo/JcpbTDdyYpBuDV0QuB5orwbJO8W9hS3z9bbuv1RUci/eFFoZ2uFwsYsUcc1RfxpBZFlsfibYl3LyiP1sv2DP8OTndz9+5i0Fzoa2JnSt53g+lRldpgCp/4HWR9ku/UnSDdHITkmos1N9WPhwDzDNn82bQFS5L0BtIL9S8GqD4vxS/ADebQ6yRtpK8GVIeKHrG5eQ93E3sOPE6kpZLYU8weskFsvMUQPYVOE2RQ2SGRXTBvu/0ow7nMj5c995OQDAGt32zNQyJgXpgSWUd2hl7v15PQ722q3gKaKWBfEXQi6iElkt/Ee5bg8hIZkHgz5JYkzv18hqoHdBTMkEAQJuS/upEA8+P6iYjQ2z6hpIR3FnEn5rortXcVeEaUwFScRRctpEWdLLzeQK3Um7vI+vYJ38ZkmIMNj9cCugc6qHIMU69DUG93Z7n241owmufGjQOIWdlyax30ow36J5GQqRXB/9GnPkk3AfpAhoNT3YYfMuSPHIpXoO7ESMaLKdywcA1jlCi0KhQ56d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(186009)(1800799009)(451199024)(52536014)(5660300002)(8676002)(8936002)(83380400001)(33656002)(55016003)(26005)(71200400001)(38100700002)(38070700005)(122000001)(76116006)(66476007)(66946007)(66556008)(7696005)(66446008)(64756008)(6636002)(316002)(110136005)(478600001)(53546011)(41300700001)(9686003)(2906002)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pld2MQNmGfC53+eS+Ae6GoIdZCMd/WCiVuNIx7lTcWFzDuBYFTdQOfjoFskl?=
 =?us-ascii?Q?rv7CBV2y2j/3p6tOBoWrHVLD6gE8gt7sPE8s3e+9AZt79iof2nakDtBJxxcG?=
 =?us-ascii?Q?giGEcXjURafK2nCJgvVtI0vVOd9sKCD0MoqDOe7ApmvbMqqjJdk4xr+bMEXT?=
 =?us-ascii?Q?g8I/JQlav7juaAd9vObOaRHbKN0H4C8di8VllYhlEATVV8k3jenwST4GkI+H?=
 =?us-ascii?Q?YCpes7tET/QHf19y5MKNzoWSNyL2RfMCIhfjlFpForWzMAX5fBWCZ/Y33s3u?=
 =?us-ascii?Q?GZwEFnVT4UpV5bh6UTGSucwQ4UE2QWBTdtKGLHJr79MlhCCwPga9k0Qj67j5?=
 =?us-ascii?Q?W+QzV9Uig9X5AlxwIMxImyoKnrW1qq3R2NHNHbav1pfQaW4QlnqNCclC3f75?=
 =?us-ascii?Q?Ore/709/65XJLOMdot3zlDo43yiYI+C+HsUw86pFQQFQtBoMs9L1dsSlkQKd?=
 =?us-ascii?Q?fQ105ZopngHmVxtSynpNXwMpDZvNo5SYARrPx+Q+Xj6CLLZXbFUtBGuTXJ7J?=
 =?us-ascii?Q?o2RcmJHp0QCrJjeXq1Djr7vJ/Y8h20M5oTvejnVMfRCd/uRPSr8ciDowHxmV?=
 =?us-ascii?Q?mI/nsMMYy1C7YoSDMYWbr/j0Tp6UZZ4C2UwhV6JgAvzS7vZLx0vysqA8AmJh?=
 =?us-ascii?Q?dCItS9nhmauxAhel4vb25wMn4BbkHXWyYO8nA65ggC2smAm1OUxKK/sV+HJU?=
 =?us-ascii?Q?5+xhPIp4a5r31U7LSCglTf1oQwgiSb48OJ8nLwMroSEKaOGo7cIzWoxOgOes?=
 =?us-ascii?Q?7nVZ3x3I/IHv6tnIxRPLATHtkWG5sJ+AEhcu82+/AM+xl7oqjE0QtKdw069C?=
 =?us-ascii?Q?m4CYZ0NFC3ZgXoKoSDr6KlqfjgLylGt1/1FGT9vDpq6qXGZQlculgmdOvKcU?=
 =?us-ascii?Q?82JVyXeaVnaO+eTj4DlTqZTUr3ZWdQ2B0BNkctYwqUlbKB3iZjFv/3XSjb+O?=
 =?us-ascii?Q?T2Xkqsv0CpYNr501OOYabham3/QqBv7/IGlgnBQECppGzbZYyg/aSiMnIQj2?=
 =?us-ascii?Q?rduPYKowTxDEGg/i85JgqH1darJpQgn4IXisHAEW1Fzn8ju+41iHfDAGvw63?=
 =?us-ascii?Q?WWqiHWP9c8ilqw+NrSUQrOZcMGdtPKPQDIeeFS6cielZv/pPwOfHa4LlBb3D?=
 =?us-ascii?Q?Egu+Ts2h+RS2O6ycajnGZA4LQSfwt986f/I6agyunkvEqxJAHf0wbDmAZTtX?=
 =?us-ascii?Q?O9upJG5c6N3OMFpTHqqZS7nt8cV2H8/VylgQx9yh2kxcK0QOc0gtJElTCXQ1?=
 =?us-ascii?Q?lHpKuJJDLjoYiuBxj2wBt7JM5BNn/CotS/DXRfwc1eSlxD/mbZNjREbZvH42?=
 =?us-ascii?Q?jpds2G7YMbS9F7EV6JYsWCho3ZFKuAnWTkD9Y0OKUZNjdDaVW3JvszeQbW4n?=
 =?us-ascii?Q?TOPTgnoWJNYbbodvVqzuE+VMafrgDcMJMS8Bn4ie5BLMO4k17KuPRbIXgTH7?=
 =?us-ascii?Q?NHb5zwcED38o4vFtd+z7rYVfEzksfRksnRHtZ7oy3djZywNwASi/Ok9YruJT?=
 =?us-ascii?Q?g2W+Kx4HTe2eKPhzAhZpytB2IDsUsNp6Qe00ZPEl03xSc/zFgZ5HTnmJm2uK?=
 =?us-ascii?Q?AsqS8EDo9LsoVPiWzsyhNwpMjDEb18xUhpdxbkqU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e206b56-a916-42b4-cc14-08dba53cb83c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 07:27:21.0604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJa9B/l4sXhsylN3lQrcaFbN1L94+ah9gFabPZSYtFxfDTSSNn9AcGhuDbzJs+DgjVmI2oonZHfegQSoxOFnQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, August 25, 2023 15:24
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: use read-modify-write mode for gfx v9_4_3 SQ s=
etting

Instead of using direct update, avoid touching unrelated fields.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index b4fdb269f856..f24a5474db35 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4042,7 +4042,8 @@ static void gfx_v9_4_3_inst_enable_watchdog_timer(str=
uct amdgpu_device *adev,
        uint32_t i;
        uint32_t data;

-       data =3D REG_SET_FIELD(0, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISABLE,
+       data =3D RREG32_SOC15(GC, GET_INST(GC, 0), regSQ_TIMEOUT_CONFIG);
+       data =3D REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISAB=
LE,
                             amdgpu_watchdog_timer.timeout_fatal_disable ? =
1 : 0);

        if (amdgpu_watchdog_timer.timeout_fatal_disable &&
--
2.35.1

