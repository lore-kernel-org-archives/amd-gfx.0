Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EED5C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 06:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A1961183
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 06:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A1961183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9786E038;
	Tue, 13 Jul 2021 06:24:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6DF6E038
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 06:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ0tLVrRtNPvUZd6KefboQQbTQVj6ddV38yucztXro1ksvXKl5BbQkXH8Kz0ShTM5GtnEeOD2BdIiNiJlhkXAGLKK3siq5FD4/PlNZs08lcYm/mQXdUuoTfxKoN5oEKNOZdOJi+k/4ZS5j9nSxZpEwNE6kmotF+ZsFiSf/jeb9QTXTjbVyCEe/eVY9og9LXaEbiWXiONumT80LZaMKz26o6EjzHOPsfS1hhSh/eWA9t0qgYDhALtqIGksxqZif1PDnacdbBDR+3Z69U3txNLbZdMKNk6gz6VHV+Ti5vdE20h+a2YeiroyMdnDwQuEJUT/wWAtiUP6fZi9XypaF8C2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwzTrzO4vK7CBKlAx067EJW0d2gSmbRauvaDcWPBQ14=;
 b=LCefh6t5cLrAuFD45zCFrgWnU+XxVye36e75HgTFznJnpz8XUIljFYvQlndLvJIctOXffQ82D94C7N1fsmv/3rZz8oce+yzpVS4muRPdHMluMXRIqiBg8lfunZPSdrOX8D5mfyGwy8/jGct+aHNAD5d7+7iB77mue1K/4YBJi6U5aGcI9QVVKK6e/dvf9ANHwFBr5nFXoR0XkS3cplHqxiQOzxmWk/+asVOyax1oXGjn0xAntNTnDvwECTPNCXaZ8PyM4+yxrfn3cHj9fVttsDJejocaAWesjufT7XeGmdXWx0e4StCFohwaYCAm3zYPH3k1FuijJeCSfDelKwqQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwzTrzO4vK7CBKlAx067EJW0d2gSmbRauvaDcWPBQ14=;
 b=tf/8OQswfZH6zGv7a2yzzAdob3qOUyl/bu9eogi1O+iveX3gA6+BkuAyQXYJ1xaeBEqs/lDnpA1aTTBdT7x8H6SQFaEbXJdet5AaUW+PJPnXrRUNyYpDo1MLcDlCHAxwHC/i9oEO+zxeuCnmxwmUluIxXBV2POFOkcUwWTq8nXA=
Received: from BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 by BY5PR12MB5541.namprd12.prod.outlook.com (2603:10b6:a03:1c6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 06:24:13 +0000
Received: from BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c]) by BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 06:24:13 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wang, Chao-kai (Stylon)"
 <Stylon.Wang@amd.com>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Yin, Tianci (Rico)"
 <Tianci.Yin@amd.com>
Subject: RE: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA
 parse
Thread-Topic: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA
 parse
Thread-Index: AQHXd6v1ryXqGlWWbUCT77GHnZJ7TKtAb66g
Date: Tue, 13 Jul 2021 06:24:13 +0000
Message-ID: <BY5PR12MB55571291988312DC700AC4D0EA149@BY5PR12MB5557.namprd12.prod.outlook.com>
References: <20210713055617.331-1-guchun.chen@amd.com>
In-Reply-To: <20210713055617.331-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=21e159ac-7ac0-48f0-8d62-49815d3ff280;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-13T06:22:53Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6efce462-faa2-40b4-e3dc-08d945c6d58d
x-ms-traffictypediagnostic: BY5PR12MB5541:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB55416816386577AB2ED8ABEEEA149@BY5PR12MB5541.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mpzNf5aELyFAWQu+ktaSYvNby3pLsrBAuqfleFZ0U1RABKwQgX3mhzBVTyAP46be75rRGsprYxordGUEl268tq6UQ5mbNVN5JqiJCxTReA7BqcYr9gr45ExqwMp8SSkQlrA8iNC65gdo6OiUpImCXybf5BaJgOhyf5OKzk+sEgvo0tZZEp1ufUBOlI50vDpUvGFtzaYmD0DPukshpoWWdbQ1+3lzWPadrj+XHqPoq/BGLDe9tiqVg4ZhGFAPM2/eQ2e8kvM7ce6LmqZn748S4qXU48US2mkt1+wr/i9fsdgx0SgfalMD37Gu3r6YHKD5oMMeXjI9U6CPFT/n2HoRixh3CUNZ0ZQdg8HD+cp7HdXdRzkHiSbvv8iH3uBiI+SH4Z3h9oLQ8IM22svE2KqL8rB48VI//vbXANuR5bG77NyYUX8d4rLmr1Hlh79zzQk9Czs9fnl+m21zC0hLyPkijVwH5TjNkkN/dLq5+9meYYeo+jUsQBt+nHH8p6klXOvllzUX1/nlUSXJczZenWWnndX3h8hHzTY0OAbNM7+RL7La2hEET9a1yh5RZEX+Lyw3Cd5BNSayUfCze5FMUP4n2DsbeYSZQVWqNfaINexaNdx5GIuCoazYAJNzi+YN+LG3hrJlaW9wbRjvLlN6w6qVq9VoHlxXoQXuL6M5/CSBUYd4F4MTVnCgzrUh7AvjNX4x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(316002)(6506007)(53546011)(38100700002)(122000001)(55016002)(478600001)(7696005)(8936002)(26005)(966005)(110136005)(33656002)(921005)(66446008)(9686003)(8676002)(66556008)(64756008)(66476007)(45080400002)(2906002)(6636002)(4326008)(186003)(76116006)(71200400001)(52536014)(5660300002)(66946007)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RhsXWcDIhk6CxTZaqWbcijDlYp5rVbzi3l1UYt4hx+ioPyMIVk5WYgYjCFHA?=
 =?us-ascii?Q?KkLDAfsH1D9GLvjb76N6D9FXmkzJlRbVw9D67OHei4QxqtuNE7sDcO5PjRAP?=
 =?us-ascii?Q?jSdXP6zIdoL2mi49UumGaarfAYEfDrRhobnxhYMClYAu2+XO8O64DjWc7QM8?=
 =?us-ascii?Q?Zb4USuUQghEZzidWUl/vu2Ng2K+HTnS8k5uslxd0N8zHlknOUOzYN235wSwS?=
 =?us-ascii?Q?pEbMM54rNQ2M1SxK5wqLe8yAF/75kRqjKFXhp/GTiXdEOxboONjY1iBJ/jFE?=
 =?us-ascii?Q?BIRQgtWdRArskvvSQLb4kYjvuN2YUtV+49jdxl8qbHRsQj309hJ3D48vgw4P?=
 =?us-ascii?Q?WyjWZjWxtGuESQt43ZtvSfRYjOLUueCq0ob0CZTntmOA184wA4VKr/UjlS+V?=
 =?us-ascii?Q?ykmLtIWX/bglcbybJ9e2fupZap8lt/xcz0WocKiT6QfnPOnItQPYvA8FbP8T?=
 =?us-ascii?Q?Pr1X06ek0Mi1WoPXxlyskDTiJHZKIAIGNBDe9AVONHjYhSxx4+rlrNePVsRE?=
 =?us-ascii?Q?OAhHtZkObxJGOKdiLeFMcFnp4H6dEBgXo0Pw+wvPXrKciGW0OxdQeFlm6MZ3?=
 =?us-ascii?Q?H1xa87gFz7+2tsNu/MhbtLPoDJL9QTTTt+4JBDJL8YLKGhYwJhi0kcPzK5g0?=
 =?us-ascii?Q?ixaHYEtS+1XU2AKAXGQSrZs2kcded0J2PxYz/pRp56eLVX5Yy5RkFAqGEhwO?=
 =?us-ascii?Q?gKlmH6aAbL7iumgKWo1fzgDsIlrs7gYdR8gbiZQF094BLCFzHpuxfZ8JGUn/?=
 =?us-ascii?Q?yyz6aQWyZsL3IPeHNINeAapauBtIGsOF41HDb9F1JpFUPoPrYV5U+ZKJJedN?=
 =?us-ascii?Q?NUxihp5l94RuaFVdh9VrYNPIRiY2olyUGeDD6gEDcs+dL5QRDja7c9y7+bo6?=
 =?us-ascii?Q?LwBFH+hK2Hgam9e77O3sSWJjkpFou2hHEsLLNBhVSAGdKIu9NjZ9XepDv7C0?=
 =?us-ascii?Q?QTlqHvE9Y4B8hN/bobWFEQgDEZIO8+UGppE4Gy1zdd9A+22vOVOb9iIpRcRO?=
 =?us-ascii?Q?JYDwg9wDBFf0idySLzNhp7VlU/vSYpwjfJdE4QsXsz6CjJp70+ttYQFNGAzn?=
 =?us-ascii?Q?IyV1wiFuKcP4WYUEu4QRjwRzhDPc1n3zTlSRel+Nn22pvJKPrGLh4AEG8c2B?=
 =?us-ascii?Q?x1uCCmLYKnXMBf4ovp83VR9FEPWvUqrxhFA7JqowumhmfgSYZNThJ/qtuMi8?=
 =?us-ascii?Q?X1rG+RDj7gg8b5RxJfqEME55+xEhaU0P6tRx2Awp+0hhHPF512gZqvRhnQAb?=
 =?us-ascii?Q?VKfj+L758WFrHI5HWOFNCJGmFD71DTDbbfRZ3C74x1htOQNLrXF4oHXFcd68?=
 =?us-ascii?Q?3x9VkStArkx4OqgYxLN/P3gs?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efce462-faa2-40b4-e3dc-08d945c6d58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 06:24:13.7108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSnW+yn51We3mEIPUVARU+LHSwkI6+3Z57zjrL3VzaosgJMnooxESSlwQszAV80AakXpA17dGGQ/yLIoUjpnGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5541
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Is DRM_WARN more suitable for the case?

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Guchun Chen
Sent: Tuesday, July 13, 2021 1:56 PM
To: amd-gfx@lists.freedesktop.org; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA parse

For the unknown CEA parse case on DMUB-enabled ASICs, dmesg will print an error message like below, this will be captured by automation tools as it has the word like ERROR during boot up and treated as a false error, as it does not break bootup process.
So use DRM_INFO printing for this.

[drm:amdgpu_dm_update_freesync_caps [amdgpu]] *ERROR* Unknown EDID CEA parser results

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 03db86bfaec8..613540b0766e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10700,7 +10700,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
                vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
                vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
        } else {
-               DRM_ERROR("Unknown EDID CEA parser results\n");
+               DRM_INFO("Unknown EDID CEA parser results\n");
                return false;
        }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7Ca95c532f01674e061dac08d945c2fb49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637617526472941979%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=t%2BJZQB870EKtzlGjp30B0zVv0loBNgpIcrHeRwiAz1U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
