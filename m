Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABABD41D44
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 01:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCD710E03C;
	Tue, 12 Nov 2024 01:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NfzE2n9u";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC1910E03C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 01:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfzgnD5NLgvoAWSHn3GiBRJQQxMzwGOnkkJ09SstB2UXdVCroQCrWeU4YhtF6UmLDHSWeW0vUKP43D3pWmCHiltzAvq8Fpprkk7ysg3vZK0yRE6Ls9TpwME5tEA+eFwVTtAztt5HjWJYCHZSWFV6KLsvDx8Dw8WJj2LDY5XDUPpVAm1g6qPA2/G8uWCjidlZIppft0wj5URTkUCsEq5uA2m61FTAOE35q/4RbnF+7K0ypnGGwYNrPQy2Xcf3cBSWISx1RG5DW57JjoDoTYAiPVgLn5eiy2RmHSW/B9hXpQ8kAaTCLC8/AWSlF/T+NOHw6EHyPx1DI0HXa2J2Ys9lFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reAaPzQqtvaWfqhERsfM/j483BVQ8RPcLJ7guRKzMws=;
 b=Bx6Hc/Bguo1eV0tgtN7EFYwWEE0w70opnQH3uP1gL9ZuDR0G/t2LWrjtpmFYM1hfT2Trqjeu5cnVuiYfigSSjsrjyyEfL4nzf9DiUUoN0omt9Sui4dKHdnhMENCvprL3V4JXDKjKomnV6eNgx2u3yC4XjBUTC1Z/jZJAAGX0osP67fzMXGu/PjAmaFbR1JjCYbGfRI/olnRIQQzy5ps44ThLhZwPGvRyCOtt+QDI856IMezm1R/nqD951MvdyNE+8NP8VEBiqg9xlELmqgSJkG0ogmw28nr+TmNvUOol1Iz+GHbqSNJMjeyXQ9tDUx+cwEDPGf/PpDmkQMb7Rrbhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reAaPzQqtvaWfqhERsfM/j483BVQ8RPcLJ7guRKzMws=;
 b=NfzE2n9uUev9Qh2GoQ+smooNT2Qz0X/z3+JAc1RVM2UKVR73XlYCX/URTJhMzycC4DC4s/41LPowCy6zenkHb7r6jYpLmoNhqjfTWEn1KKfuW/CnuCdCUnB6YvGqXZn4gAldM9ik8LHNUu+SCQ6jBsqqCIp8bvxEqRq+qnq013I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 01:23:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 01:23:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 02/23] drm/amdgpu: do RAS init in NPS mode switch
Thread-Topic: [PATCH 02/23] drm/amdgpu: do RAS init in NPS mode switch
Thread-Index: AQHbMc9q0W7uoCUAqE6TIGyYJZ+k+bKy3ojA
Date: Tue, 12 Nov 2024 01:23:30 +0000
Message-ID: <BN9PR12MB52577D6519C65A03AB51C69FFC592@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
 <20241108111423.60169-2-tao.zhou1@amd.com>
In-Reply-To: <20241108111423.60169-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c6b4641a-b302-4ca6-a105-ab2e08760ca4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-12T01:20:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6041:EE_
x-ms-office365-filtering-correlation-id: e43503b0-ed2b-4a3c-4eb5-08dd02b89e18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3TDyVjei0pYx71Ntrya2ylex6F7k7zU4R9xqCg5nmBaBe/oOkX/KXu8AbICZ?=
 =?us-ascii?Q?V72obj2QNmqFY5StUcVQOxDZXk/MCYnPleYj25mvDEahZAAVO2DgojRh8KSH?=
 =?us-ascii?Q?K39tSLwWA6BMOLfOSvNzGcZIjr+8jQ9nfnzpaumpCQI5jKb74veeAMiP00B5?=
 =?us-ascii?Q?dxy+b8FqhSMEJ4EIFncWt8ADRYNCq+FCLwkN7SAQ6MjphHA4FDt8Kghvnrsl?=
 =?us-ascii?Q?J7Wl6FjYtrHVM9rbYIUtWTJHQY9VEG9et0BZz042M7Wy7QiFNh8ZE1tm5wdO?=
 =?us-ascii?Q?b6wUzSIhph7I86PdTUYqMlYA4yxBKxALxRLPkbhzqvS+YKuW3sb28+iC3QCe?=
 =?us-ascii?Q?6hgA/DPjXe9RaLKy5F3xQKa5hl7OUusJIMTWYiBMTR3CroajdD2OgCQ7PImm?=
 =?us-ascii?Q?eEU1cL/SLiaHKAkaepzx3ZCDn/fc79iG5rw661acPoaNsaDWRmaafLTMWmEO?=
 =?us-ascii?Q?Ip+AhGir5lT35/AgaZtAQxQfT/1JZJDfx1HMlLIMoDT00K1SgsQWq5OV8oiF?=
 =?us-ascii?Q?/QjhNIH1dsvOXHvon6UNCL5ByhbfAJx2SL2A/Jb/2C6XuE8Dr7JO8DVk/sxX?=
 =?us-ascii?Q?3Tnu3YbWBpUt5PWU0VjnAfdcEqXIOE4A5xjuGKZURHGAO5HFFwrv5eZYs552?=
 =?us-ascii?Q?8ZjLUkfiCOESqCXAdcZzI0rMfRwCEDUy4cOzMrgsnCQt2Vl970hhzZhW5aSO?=
 =?us-ascii?Q?8gvYofkH1veb/p9sztMzby4ZKObgclvzPwrS9ufkbXih1/Ql7pAzKl0eRTks?=
 =?us-ascii?Q?IW8y+nVHuHJmbFp66HM12D5Y1cdfkkAPtzjcdV5ouzsD/0fuEZStIxIa2l5Y?=
 =?us-ascii?Q?fkReQyrVcSYdAK5TXzyRG4UqRy1e+t8tZpq4KNoW4nXnTrJ9as8GmjdI7F3K?=
 =?us-ascii?Q?HzXnaLRue0iYvJgP1Muws1dHxEX3CjbSoN3fiVzPH0Pa7Ze5p9Pjl1Dj30b4?=
 =?us-ascii?Q?kQ8HW2MznzeQ/kq8y9G0+QHYoihX7saZ+wg4QyI6QCLZwt7RqjzNcwlxCGfy?=
 =?us-ascii?Q?f+nx3ayn3XdAKCtZMYJCGgF2OMOz5vudOS17ASxLJLMcpp/590OvSk7gtrQe?=
 =?us-ascii?Q?5527Yzq+fyzL1BVaiYgVjtlKSIAisOEBzXLVXbpD7uT7yFu2HstL2j5gR1mu?=
 =?us-ascii?Q?udyeUK2V3TtAP1d8+AO10gRQwofea8Tmynq5lqYAITn5QK6uPSm7ULbAlhW8?=
 =?us-ascii?Q?/sfkoV5+DSu1jI/Yv6VQWA+rpmc0XeF4QvZFmfZnd9YZbgwwo6epZtprkvR0?=
 =?us-ascii?Q?dY/zg4QACGgfTb30ylGZVTRkyQna506bBbpVgfHux5XTaTvkpebZT1r7k49H?=
 =?us-ascii?Q?XsQc+0JO8aa9Ofu/e7EoLI0MLDmkFyEpua4eRXRVC/IVJBpzLV7WSYEAJYRf?=
 =?us-ascii?Q?RBSWh2w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q2X2rIlPuiOQ/qBEvVCC7PczcAbtU6zCDP8pkTv+FyPPi/ypd/XgDtPgQeLF?=
 =?us-ascii?Q?xMVpq6v1nmx0oo2mK385KZrjgpsezQPtwUz5gxhF9LKOBfgNjDbg85B/p+dn?=
 =?us-ascii?Q?Wh2Z75OiXTGDQmq3mMTMVfk0bFMuC6+0JSKGklWPJKp4+kVzIWoJ/SaREqk9?=
 =?us-ascii?Q?up9cFROehjqDnmKWjABDpH8Ird5AS3I2GVHyJJMBYPbXkke/Npc1idOUV6sz?=
 =?us-ascii?Q?dNG2R+dHroUSHlTDdNI1UXwBo8SW0CnUQRq4b5AbwA7K+9201yyVx1mia7vD?=
 =?us-ascii?Q?FUSh7g+rV3HAVluhgPikDOEaEPhCB9aXaUSq0CjQ25To29c3wpy4Y8X/Xzro?=
 =?us-ascii?Q?fqjmBOxtrIL2oM6s99gGph8AE0rFvPClrY31bo39r2G/MthUU4mumXgWNCW6?=
 =?us-ascii?Q?t++NiIJoG45m1lIvFxOtnWzAd8yiK1VySlLV2Eb16bS93d0Kbl+YG0Njq0fY?=
 =?us-ascii?Q?ISORJ5vf9N/wmTX1ccD+6GnQCGOj4zKVag+CwX9SipJTNaziK7IgURdKXJE7?=
 =?us-ascii?Q?PEuoN5IQlZjmx1TEc4AcTXGo/ofUNKf71BX3OYAJ10cN8cvRuT3IeA8cE0xN?=
 =?us-ascii?Q?++y90Kk8TEOO6B9ZKnJiztFAHd/49EewKcOWcxPuRimrLVIdN7C2U5iGe3Q1?=
 =?us-ascii?Q?SSzjY8SH9iKKi3C17h9SppUxOSZYpozuIPF27qzqDAHNjR2iRlfnAYDkPmkQ?=
 =?us-ascii?Q?az9+/ww96gIEvOfqdADoz4Aigojz5GYfjyTM2j3jrAj+I+Xs3vNDycH5V8C1?=
 =?us-ascii?Q?gbT7TztUlEfox6UtWnTB1reBd7RA/z8D1viXkOzi48ZcEYEPt+dewOU9Ah/3?=
 =?us-ascii?Q?BLkVutWRcMheWFS9LYxiuCNBfQHSt4+T1goiSzwfnoHtqzJwqqCgb05M85hm?=
 =?us-ascii?Q?iq9ydD4ke2l5qbP6dRHa/EPvxCGgW+G1JGbBA53eQA8qbSFfhYMeOGlp7Fue?=
 =?us-ascii?Q?dnp4VuA2GedXkZN+mzhBj06Luxuq5acd8EvqyoRpS5lsGfIBZ/RZK+LwC0j2?=
 =?us-ascii?Q?sllm0F0vAcGPBbpjhhryUW9VVXg94Omm97dHepUDGfm4bE1JDYOhQxKbYbIw?=
 =?us-ascii?Q?9BEcOrf7C7dto++T/nuU03p1o9dPcaWSMVrz3+r1PYvSkzXeNW7dnalc5wXY?=
 =?us-ascii?Q?WY6aIwdYXauZ2Jpt73ZM3TK31ogIqXTCzHHNgTTeaoPKaZvRuU7pJAiKs+17?=
 =?us-ascii?Q?wJI0viJWdGj/kr9+0YCrQV8+0IrFgVqGs9w1loqCe5U6IWy8bwxTD2CW27De?=
 =?us-ascii?Q?yEo2lzL7MqGMPmzToSIzBp9JUNFlnQU3SjEPg18FO+DEuN8mnkm3QAOV1bRW?=
 =?us-ascii?Q?/NW2tM+HoDQAJCSD0bky9moC8Nhl8hLGq/DO97BLdhZ1aASkhWAmNECw2ZBR?=
 =?us-ascii?Q?xApE6LTlkNopIduUtwolZztrtxCQ1NrVpcP8YtCp7LnkvvQCnbaxKdqIiAXT?=
 =?us-ascii?Q?zNnQUxcYTWLHW3scHsrQC1C5vSCSaqq97kdeYJBlAKPCdENkxaAY9TXuGIve?=
 =?us-ascii?Q?jlO6nOjnMHXhb+nOWI7AK4O0QpDzuS5n6zJXyqHRyatEj4kN85wwwKzsYH41?=
 =?us-ascii?Q?Z7I/AcWndrAu7K0k9vg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43503b0-ed2b-4a3c-4eb5-08dd02b89e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 01:23:30.5768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnIQhNYGJ7p/R0TIlfWb+kzmsCzJSfs0/6fdgxXeiG6SmgBBw6/8B65AoLRfMFN1bVEKMPnj1u1nWBPFp63/Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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

In nps mode is somehow confusing. We'd like to differentiate recovery (*aft=
er* reset) from regular initialization.

Is it possible to replace in nps mode check with more general approach? In =
regular initialization, set ras interface available in ip late init, while =
in recovery, let the flag set when recovery is completed.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Friday, November 8, 2024 7:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 02/23] drm/amdgpu: do RAS init in NPS mode switch

NPS mode switch will call gpu reset, but this is different from normal rese=
t.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index d69fcbb28b0e..635f020f8d9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3293,7 +3293,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
                return r;
        }

-       if (!amdgpu_in_reset(adev))
+       if (!amdgpu_in_reset(adev) || amdgpu_in_nps_switch(adev))
                amdgpu_ras_set_error_query_ready(adev, true);

        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE); diff --git a/d=
rivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
ras.c
index de1a55ae1d78..cbecf2380b51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1253,7 +1253,8 @@ int amdgpu_ras_bind_aca(struct amdgpu_device *adev, e=
num amdgpu_ras_block blk,
        struct ras_manager *obj;

        /* in resume phase, no need to create aca fs node */
-       if (adev->in_suspend || amdgpu_in_reset(adev))
+       if (adev->in_suspend ||
+           (amdgpu_in_reset(adev) && !amdgpu_in_nps_switch(adev)))
                return 0;

        obj =3D get_ras_manager(adev, blk);
@@ -3780,7 +3781,8 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *=
adev,

        r =3D amdgpu_ras_feature_enable_on_boot(adev, ras_block, 1);
        if (r) {
-               if (adev->in_suspend || amdgpu_in_reset(adev)) {
+               if (adev->in_suspend ||
+                   (amdgpu_in_reset(adev) && !amdgpu_in_nps_switch(adev)))=
 {
                        /* in resume phase, if fail to enable ras,
                         * clean up all ras fs nodes, and disable ras */
                        goto cleanup;
@@ -3792,7 +3794,8 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *=
adev,
        amdgpu_persistent_edc_harvesting(adev, ras_block);

        /* in resume phase, no need to create ras fs node */
-       if (adev->in_suspend || amdgpu_in_reset(adev))
+       if (adev->in_suspend ||
+           (amdgpu_in_reset(adev) && !amdgpu_in_nps_switch(adev)))
                return 0;

        ras_obj =3D container_of(ras_block, struct amdgpu_ras_block_object,=
 ras_comm); @@ -3922,7 +3925,7 @@ int amdgpu_ras_late_init(struct amdgpu_de=
vice *adev)
        amdgpu_ras_event_mgr_init(adev);

        if (amdgpu_ras_aca_is_supported(adev)) {
-               if (amdgpu_in_reset(adev)) {
+               if (amdgpu_in_reset(adev) && !amdgpu_in_nps_switch(adev)) {
                        if (amdgpu_aca_is_enabled(adev))
                                r =3D amdgpu_aca_reset(adev);
                        else
--
2.34.1

