Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8DBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 08:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4CB10E3C1;
	Mon,  9 May 2022 08:26:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C235310E3C1
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 08:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du96jsHGhTUZj1CqThNQjq+dlTi9MCbHBgs7mar5gYCN5yJkA47xupqeSPqh9FfHFO/mSFjfJynN2RW+eGMB2J1edSdw3aBkIxeHl/qvnjpWkZH+KB9XzfNlcdpTJyELwSdPEBM52Q8P2uAzvLkszlU2TESf1Fl3m2d7P80I+3TpCmY7Eu0QSc5GN0u/RQkZbW12UdnORpWqJ1ABpIx9gopDVcMNMhebwTz/YQBf9TL3NX5ED6dmZLWzTOwfOoivQGZClA5GnTILF78P9jIgpG4EiaK4AKZEMUpfGZzNx+JhR33QIQDmC1csQLF2qgjkVGhObn4ED3moZ3Tv7LMzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/CiBrg97ZKdVd/EjVIW6wA0oQmtjwx549vO8rxIKQI=;
 b=mgin9aStgQ1hgVxUN50vd2DYpm0kOr2iZdEWvPmCJRR16bBIt+CdkiofGrSkfLZ4fgnEtBXuQFPzDLqub5JKB3Bprt0cguIdiljsNvkjpCJlpBO5hxQRdn9o2CpTleh727dw7NzBBFHkSryc+CuLO6EoErSzB73jpqsQDsb7jJ0crHJ6qyvayYZsZr7q1kMyql8GA/yb6S+XJzYGQbfAUGfKFlg71LlgWWxY3Qkm/1OtvNjGoRgIZdnxs2hCA+pwWrNX5Zh7pZSkzBbdXGn9yCsHTF9WfTl8duWFLbKgkonknnscu/gByWjWpawx+DSHllWx18xlnvuc9qK7GfX0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/CiBrg97ZKdVd/EjVIW6wA0oQmtjwx549vO8rxIKQI=;
 b=jjC2xCI2B17F+PVKS1DQv4hnfd1R5FRihRAUtaUf+ItUrQU740hVBRdmwGXCaJYko6DQftygJqewA9cd0T1EAsVJ+9+JRVFGMg6Iuv13VaToAadxrAkjlUR8UkrhN/2JTdsxuY7nIOZyDDeFD34ZpLUWcmurKT5QjW/hqNct6Wk=
Received: from MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 08:26:12 +0000
Received: from MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::4911:d6fa:f15f:a139]) by MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::4911:d6fa:f15f:a139%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 08:26:12 +0000
From: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
To: "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 05/17] drm/amd/display: revise Start/End SDP data
Thread-Topic: [PATCH 05/17] drm/amd/display: revise Start/End SDP data
Thread-Index: AQHYYIvBbTmF5oEmskapqDjTlS7L460WOopg
Date: Mon, 9 May 2022 08:26:12 +0000
Message-ID: <MW4PR12MB5668092BC7B387636C86877A96C69@MW4PR12MB5668.namprd12.prod.outlook.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
 <20220505142323.2566949-6-dingchen.zhang@amd.com>
In-Reply-To: <20220505142323.2566949-6-dingchen.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84e11754-a8ed-49fe-1b0d-08da319593d2
x-ms-traffictypediagnostic: BL1PR12MB5319:EE_
x-microsoft-antispam-prvs: <BL1PR12MB531930BA00584C6A24FE527F96C69@BL1PR12MB5319.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /40cmH15ExUZ5wBRG8aSElWMae5niOQFQDg8S6sQGydTqrOevn8bn/ljlvp8pdHJsibV5yHtWsv9ItuOBw0AnywOM/IRkvbczX+q2lcjSHpuB3EbkoPgqPaxaRds2SDFjtN1HOPgLAxPTLy47iFTt3GtRf5dJZQjZVKPM6hhdn1NKYm/MDaTJ1OTUD34CgKXEz+EQZxsW3hkA7QZdOiDMLOk60wyzUCUNkkAPsjaAAsQEmw2G6DP6ajkv6I0cD2/axPxUDyOiAUeJuFP6N8fttw0sP/5Wgrr8z8tqKKNsgeMOQIVeLNEDavaZMAosZqXmpURQ04tKDwfMHI1uw7vrZ8fOGcKOUqxJri9gNul/aCjuxTdIgjyu3OEL75RrlEF1AugdoA2GYZMf06zAd2R5pA7qWB85NwQjWjZq4qF6y/ar74rm9rHUbZNbYViuX/DSh5L84JY1TftcpnqP7wY/y1DjiBl9Ft7aV9Tu17eDApLD3JJzh7PyJCOVg3cjT5IIP1IKUZUdzsxvOoR+UNega4n9huwsVmy89jF65cQTaUDM33An/vfzO3gLTTKye7xsFG9+0oUPxt2hyYu5di2Hzmke952tZ8nY0P8VJomr+lpjcmeKkyLGnZ96b/o0kt0wXY8jxG4amKKjQsevD4mDa/fU3CYgdl/uQU8Poqw2IRdJNaV+8Yl9KvnILW+6yBfQ1T8seKMEYhYdDbDh5PcdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5668.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(2906002)(122000001)(38070700005)(38100700002)(8936002)(55016003)(5660300002)(508600001)(83380400001)(186003)(4326008)(33656002)(66476007)(66556008)(8676002)(66446008)(76116006)(66946007)(64756008)(54906003)(316002)(55236004)(110136005)(7696005)(6506007)(71200400001)(9686003)(26005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TTDBJD6sk1MN4yi87HYrqA0YDsNFeHU47usXDK6hwgDKRuAp4DQ7SkKlUSxF?=
 =?us-ascii?Q?4zmo0PauFBaS+7zcP7lIUWezsQ1GRJgcjjhD+3VjMYx9njZX/tgapSd+8BZr?=
 =?us-ascii?Q?fjGBeYXLrpv2hWfA+oF9C7Kv0FZ5BSliZve/NY1ifcrbg1bRwSMMRzGSumpG?=
 =?us-ascii?Q?APxUsfUTjf5KYv4XkbRxlaaX7zGRAscS/B4uiyyi5P4uYj59EgAoAz7odPKv?=
 =?us-ascii?Q?bjcK6S7/fp22E8OffwP6N0/IbZNwKOXJwI2V+zK6jUi0tOcfqPeGhIg1TiCz?=
 =?us-ascii?Q?rgYwne0T7HHAx8ntdu0+uKhXREHH/Lm3Iba6ChkPpVoGqlHtGoFA/uR1pz+7?=
 =?us-ascii?Q?rzD+7ONJCKYgkvGdHv/wDjdST4lTiSa812leGDx96BlnuBHue4N28ZV9zfJD?=
 =?us-ascii?Q?SMYwA7TDH4WtyUSyXK7h2oCQ0XfzpleG9QNI58Wf3EtGJVWFN+pIp5hD+Hpw?=
 =?us-ascii?Q?BBZWTnVQwT3andrOuCZ4bpooPt4qOdgzjL+p+ulDAhCfjWTiY8jI21Fztfg/?=
 =?us-ascii?Q?7B/GaZ9S3+wvNIkzmm3nF7podxUzFooWtu66fIOi3fiHLO6RbqvMlQ+sKoEd?=
 =?us-ascii?Q?u+k9G3IiW39p0Cake1aOBmUzD05cljOlpWp0f4NMV+e9X2lSh3rCblztPf3D?=
 =?us-ascii?Q?8ZufgmStjPHU46S+hl4fCn/svS6w7x+Ch8/U+XsfKGU/xd+g6OtXzZSxT7ZF?=
 =?us-ascii?Q?1dCsjCgqhlOIhPBt7AtNTJm+CkS8zD1gV3ClaCSvNaxqazUd/xzTmm1qjpQ9?=
 =?us-ascii?Q?qdsXxWEpHJvLurmxaQGiSXr+b3XTrIg1QWghYvc+Hxtezu11ElaV/Qh4lzyk?=
 =?us-ascii?Q?EMMzNYPM8g8Ws7ybI1w/BOCI8kavr2r2DyZVLRp/tqtqL40NXrr7XD3O6swj?=
 =?us-ascii?Q?yw+KPbmiLvrW1urRn0l6F8Ao+y0ccVLIxB622ZVWz19uz2XOJr+UCTwvWbcC?=
 =?us-ascii?Q?ZkXn7kVKMpJjSW4kqtblpZITVYGObgBiTl3XpOr1Kd5g55ffufxH8Zl1cx4c?=
 =?us-ascii?Q?XoHEU0YtKRrFYUgdzxNVBCN061hcu95qf8tKIR6Lc/jOP8EBSHhfNwWAOMmF?=
 =?us-ascii?Q?aMlKedMXEH83cIyYHVTCbkZx1hhGN3Mx4MLFX+Jo+n4L9opmLgaCzExrJ7/O?=
 =?us-ascii?Q?mtXwwPw9KqpEo1JMicNBjrEpIKs7hR4c50dK5yQr+0hQjO7zqrkTYmGpQ5pf?=
 =?us-ascii?Q?LPngRis5Er9VIKEg9Be4L4FC8frl2emD4SyFyNzmvmwU0GGtk4QYBwb/WX3C?=
 =?us-ascii?Q?ls4tqGnf4MtwWwvQM+33pbZNs3FPbq/LZUAnKp+n9FKHOmvD1ZR4Z8A1Uhd0?=
 =?us-ascii?Q?mGMvENtCZezUd3y0bJ41ugk1S0lGpSZNWoKV1UBuxjHGG657R5DyJ6BJ3csJ?=
 =?us-ascii?Q?GDzXapTfLuXRbCFRhYrpt56HyQhC9mVjqeD7qqql+uOJWe0JyFbG1uJBEf+t?=
 =?us-ascii?Q?pRybkuC7xHKzqI0JfbLO27K9CM392IaBwBViWdEqR3dtDd/1/7mbRFcW1ypd?=
 =?us-ascii?Q?TYy/cG12WAXfc6m7Hw+UwxsSCYTZ+SP1zhdDjwkfHSrKfxVio3EsXtEnu8Z1?=
 =?us-ascii?Q?mF0Cbfugvs4kVS6v2uaMQgtg321H+H+dtbDhaRJ9iqsrquyeNJljb9K7z7d1?=
 =?us-ascii?Q?c16nUjnzSg4+F0CY0kUthUEai5lh4QkPtrC3MksWnWpqm3edJCzt4NwrwJUU?=
 =?us-ascii?Q?n4WvL+/yJ2kenpqbQCHBDHKnWwhBh+vKfLqDbwljuo3jhD7ZFYQuTz8JfzaU?=
 =?us-ascii?Q?JN+KKRVz4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5668.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e11754-a8ed-49fe-1b0d-08da319593d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 08:26:12.5942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KfDyflLe424pseAPlZaKPfALIYtDnOYI+zx6XLPz4+ScaGlfVpXZYO+4hjRaH2jKXHRJccrX9gbnAdpnXOXlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Why not set  "vsc_packet_rev2" when "stream->link->psr_settings.psr_version=
 =3D=3D DC_PSR_VERSION_1"?
This would be safer for future PSR versions also.

BR,
Chandan V N

>[why & how]
>We need to implement the VSC packet rev4 that is required by PSRSU.
>
>Follow the eDP 1.5 spec pg. 257
>
>Signed-off-by: David Zhang <dingchen.zhang@amd.com>
>---
> .../display/modules/info_packet/info_packet.c | 29 +++++++++++++++++--
> 1 file changed, 27 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c=
 b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>index 79bc207415bc..c7d1b48c0478 100644
>--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>@@ -145,8 +145,10 @@ void mod_build_vsc_infopacket(const struct dc_stream_=
state *stream,
> 		stereo3dSupport =3D true;
> 	}
>=20
>-	/*VSC packet set to 2 when DP revision >=3D 1.2*/
>-	if (stream->link->psr_settings.psr_version !=3D DC_PSR_VERSION_UNSUPPORT=
ED)
>+	/*VSC packet set to 4 for PSR-SU, or 2 for all other PSR support cases*/
>+	if (stream->link->psr_settings.psr_version =3D=3D DC_PSR_VERSION_SU_1)
>+		vsc_packet_revision =3D vsc_packet_rev4;
>+	else if (stream->link->psr_settings.psr_version !=3D=20
>+DC_PSR_VERSION_UNSUPPORTED)
> 		vsc_packet_revision =3D vsc_packet_rev2;
>=20
> 	/* Update to revision 5 for extended colorimetry support */ @@ -159,6 +1=
61,29 @@ void mod_build_vsc_infopacket(const struct >dc_stream_state *strea=
m,
> 	if (vsc_packet_revision =3D=3D vsc_packet_undefined)
> 		return;
>=20
>+	if (vsc_packet_revision =3D=3D vsc_packet_rev4) {
>+		/* Secondary-data Packet ID =3D 0*/
>+		info_packet->hb0 =3D 0x00;
>+		/* 07h - Packet Type Value indicating Video
>+		 * Stream Configuration packet
>+		 */
>+		info_packet->hb1 =3D 0x07;
>+		/* 04h =3D VSC SDP supporting 3D stereo + PSR/PSR2 + Y-coordinate
>+		 * (applies to eDP v1.4 or higher).
>+		 */
>+		info_packet->hb2 =3D 0x04;
>+		/* 0Eh =3D VSC SDP supporting 3D stereo + PSR2
>+		 * (HB2 =3D 04h), with Y-coordinate of first scan
>+		 * line of the SU region
>+		 */
>+		info_packet->hb3 =3D 0x0E;
>+
>+		for (i =3D 0; i < 28; i++)
>+			info_packet->sb[i] =3D 0;
>+
>+		info_packet->valid =3D true;
>+	}
>+
> 	if (vsc_packet_revision =3D=3D vsc_packet_rev2) {
> 		/* Secondary-data Packet ID =3D 0*/
> 		info_packet->hb0 =3D 0x00;
>--
>2.25.1

