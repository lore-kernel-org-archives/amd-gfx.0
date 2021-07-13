Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B59C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBD1601FE
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBD1601FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E5989E2B;
	Tue, 13 Jul 2021 07:55:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A76289E2B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 07:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDi51v0+4DrSrkd7iBivMvEWTTES5JY9wImg8/RIcFYWixhtKe78TPTEWZupHU7gzzhtN64Eb9I3mKjziUEA8ys2t5ybF+alWdWU2H3XQ3H7BCNBOm37wGbcAOcHu1B3I+D1L2dA6avBGzcvjoz8tNs0qzaEl5HnzDsYAbEoRzRkyA/NhZ5kLBTsWEJ5sg/1Jaetjy0G+kZAb4mFq5FNf/LXNSjOdwrpZ+2TbRqOrmgxgan0AqUOAy34XO6OApCTgrWvHFXZqJdAxvE+zG7fV4KVZBO9p5qQDVKYUgMvn9aYRkxva8rnXQuGwmA0d1Nk+Y/CeaObEVkE7bJjv20psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5PqbzhEaCUZYjf7OWVwI6E34I95vKU+WXyhjU7tfX8=;
 b=VUYA2G6A2cClWcl+IUv9UySDRt5Qy7PakQ4e/MJEmcDjBJRCMBPaJQ06fGM+Lhrg1n+svrj6EKhCyqMi6vNgeYrY+MRgkNgFssatnE1JHw/N9XIH9U+9Ch35FNR6K5ZY5c3XlRSA757Y4P6n2VBksBGU2V2ph9qdMkjrNWMmw34rxKzBu6NnS1St4T2URAZyUduPIN8fMgiKxyHSBUPSEWSRY8cjKo95HoHUPUljletYXaNhPBeX9QyeqNFFuEPc8LjaiJ4MM+0JdJ8l4yLCwVs/6RL/4H9wB3OC4AekV3JkNzNkEAgd6+E+c1Q2tTX2bk9UzxGFcmt3ykwZZEG6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5PqbzhEaCUZYjf7OWVwI6E34I95vKU+WXyhjU7tfX8=;
 b=x4uT1dAwQaVwN1XaCsjUkTTuoC1GkfZikJEVveyRM8i6K7aPbSdfwgKzg4irRkIR1uRBPsKwMB0IJcZE0MBGc9PwEYPZzT3LQAzuqiY1aNKDA0p+Os1OyUcueenq0NaWFYNMbiPXLknuDpp9nO8PnxwtKJSiFH4js7o56i3bEi4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1560.namprd12.prod.outlook.com (2603:10b6:910:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 07:55:45 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 07:55:45 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wang,
 Chao-kai (Stylon)" <Stylon.Wang@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
Subject: RE: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA
 parse
Thread-Topic: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA
 parse
Thread-Index: AQHXd6vWePaDgUV/hkug5XkXydB0/qtAcA2AgAAZQNA=
Date: Tue, 13 Jul 2021 07:55:44 +0000
Message-ID: <CY4PR12MB1287C8F728B6115D129A0172F1149@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210713055617.331-1-guchun.chen@amd.com>
 <BY5PR12MB55571291988312DC700AC4D0EA149@BY5PR12MB5557.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB55571291988312DC700AC4D0EA149@BY5PR12MB5557.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-13T07:55:40Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2de0c302-b0f2-4140-9a97-d9a5852ae1ec;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0990298f-7192-4a01-c24f-08d945d39e9b
x-ms-traffictypediagnostic: CY4PR12MB1560:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB15607FB8B71AFB43B7EC4198F1149@CY4PR12MB1560.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4uE3O72ogacFDG6nC7gqC3SXdjGF+x+sgvuDbAvUlv9IWDxXQWwPMTjfQxJiWjsTTorqu/ETJ5VLov4Td1Ts+WNFRrA/otXCBRgCNxRWf763n8Cb0tfAac/bHvWih5zRXgoCjibUXBUR+X1rCSSsqMjucu3yLrPDr/JGftI7L6+VpC2TlH6mUBlzdVvevPaqxXpUlHZPxC0L4md14claPjw2879WkSIDd6dItODk/ybaqtYNrSj3BEQx2dng4CewabREsZuG49ACGiD6jFqtoy99OvannXNNmZP+dOgV0+rHRstAA25JxhNUEnn3liY1GyyuOFU8ZmwXcRL3MUjjh8NrDGr7EjAD2VXXqhXMyOeFKP7M2Ef4WITzF99Du5XWruJHrnQCsGiRxlt3jF+vVmzFvCAl1S6z16yITI019bWGcBAlyYS8m9l/1EYdYHsL8wU8oOBo/ioN/lM1iTcNd7vhjJ+btY9eZFQ1DkrpP6rc4V3CnggodVgceXxQ0RmvcJz5AMaehnalC/5jiYT71NNMK57sZ/3/qsFo7ycsjnOaxb08hpn5ASvp/jgljBG/xPNJ1n2/nU85ni5l4dTYXVQTLrSmdwBSnEWD4TwxUi84wkb2uwj2+BdBZDdqlm9VIvvORO0plB5Zg4Sb0VmqyxhYbxv5JhF/Jq1LIWTdtpWktF2Mt75YFJUklG/GuJm5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(38100700002)(478600001)(45080400002)(8676002)(8936002)(2906002)(9686003)(122000001)(7696005)(26005)(6636002)(71200400001)(921005)(186003)(83380400001)(966005)(6506007)(5660300002)(110136005)(52536014)(55016002)(316002)(33656002)(86362001)(53546011)(66446008)(64756008)(66556008)(66946007)(66476007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G1eJS296qx0ABXGZmkmwfWoHjq7GZSuIs5D3mNZjDVIODylvcPFeMbdFKmh2?=
 =?us-ascii?Q?Mk/KFRIzSZyfh21xwzHLca6rANpKAEh4Un1zeODkeYARedL+nP8fGSbndzWn?=
 =?us-ascii?Q?IN/ddetNJH1w2fWFEg2yfyRwPBZXqmYXNmTAz630dhk4n2Dfoy+mki8mTVN3?=
 =?us-ascii?Q?AJIJaT3eWLGWdtDjx1lhdt09GTgg1Mtvje+DSfJVzSYkgL4nNvY0W0h7ldwz?=
 =?us-ascii?Q?Gdu7EgF48/g3WA1wayYPuoYkAzERbmcxg6RdpLTIGneWIF1a+cYbsDF+GFGT?=
 =?us-ascii?Q?rpbJv/6Y6MHywHkc/NAxTN2Dhd9QWxtxEO33fNqWVvlCqSMT8Duj17foIlrX?=
 =?us-ascii?Q?whIqh4GBhL3VEPe7AKzPlJ2TceKFANa5qW5Z8/jhJPhfWGfIWveS+4VjygTi?=
 =?us-ascii?Q?ZQqGZanTbAyVzoMsnQKvFKeDb1VJb97xnQWInTZUvoMfzIy1fr0rRrt6Oe5S?=
 =?us-ascii?Q?g1xIJQw6gxjqUzlhV05juF+CzIjIcj8YZ8vogPTg8YonOm7CZHIXzSzmsHgs?=
 =?us-ascii?Q?EsDFu9FEUsmXYCMKLLBmwOogVl7FXAPX2jTHeoQ6Pl7cl1px+MvblX9l1ZU2?=
 =?us-ascii?Q?sfD6cEv7toFQlzbB7IEpZmq6UNyDjnXnz8o/QB27bk2fzM25Kszt4Gn9cXlj?=
 =?us-ascii?Q?IWCwceFbKi1PCGg4QJ7S9xScomwr0u6Ox03BnXliqrapQIS0Vsf1dRRXD9Ao?=
 =?us-ascii?Q?p5QAqZmYvxNeznqytlhbO4b0VoF4Oiei4NdxERffvFaEvtKzLrOa2jkSGW0i?=
 =?us-ascii?Q?5JrgGi5J6qRqX5HucreAMqLElcqH1i5Xvg0ZzgjG0Sf1T5QJMD+6RKT5xwXI?=
 =?us-ascii?Q?XVJTQ9jl5ZLC7bN4utSme+MwdYAJdVeDHkHhD2y0r+AW3duaUvVdZai9Qp+7?=
 =?us-ascii?Q?THxR7UJI+q1nvcrUNM//zMq+GGIxh8Fm/PAeqEC977myL++lO58nJBi8bdh9?=
 =?us-ascii?Q?n5BiWhG4JbM1VMKlfePQ1SZziSLGBrQs2w+9mH/j3GHqO+gRx9lWxk3dVQCI?=
 =?us-ascii?Q?vq3RhblB/ic/nYh+Quqo2zISsOQUgJ0mdcu7m39xPW4NdGN+cU9IVvlVeWr3?=
 =?us-ascii?Q?2uzmIKkXmQH2B6xLv9J3FmWcnotaYN/caKp5cMnJ6aaBXd8Oeu+ChT6QnLfv?=
 =?us-ascii?Q?QWQK+SfYRJbTwGvPkDkMOdx3nyOStqdf3Wans3JyaNeq0XK/hk8zFmNC3uEt?=
 =?us-ascii?Q?S5/5LHQuwPh0aH9DZKVvSwgfMwE/YZRLTNUWJKH9FMU9XYsy5lgOybQMwp2A?=
 =?us-ascii?Q?Mw87HcWzemPZBV+Ub6y/wuyxik2p7YQUkY3W9vf8dnDUJBvlc7ZA5MD8HEjz?=
 =?us-ascii?Q?1j6AL/1lT1fFIGkvx1xozQlo?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0990298f-7192-4a01-c24f-08d945d39e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 07:55:44.9280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSvlOMOI4Mo3rgF0BL4EcjZ4G70it9SQ1OI9cffwfKzfI9fVm7cc7ce0K2I+fZAD9mQ+XQPjatZcJgahFGyVIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1560
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Good point. I will submit a v2 to address it after display team also agrees on this.

Regards,
Guchun

-----Original Message-----
From: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com> 
Sent: Tuesday, July 13, 2021 2:24 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA parse

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
