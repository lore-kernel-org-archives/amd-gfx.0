Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06915C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95D060E76
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 20:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B95D060E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B256E5D5;
	Fri, 29 Oct 2021 20:25:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42BC6E5D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 20:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtYDfl7xg7iNL52Jth5BSD4EGWs44IPm4ryPvK2Skv+sPqm6MwT5ts0ZljQSke9CapPGHEQD+NqsTDCHSQG1JC9gj750iGO98Xwoc+IGoXXYLfpjC+WIMubfaLktFkIVguAXbK5abD08SUmTjx5rOiEPNKVHizKo6xude5W0JRMqPEz4MaWS0ovaR75rMT8uslfJ5Dh1WTYdQQG0s4C37mDbg9fLGWwwnsThXFP3uLP8s61RvKNiPEDWGV/6YyCa7+imz3M/Z8BA6owqaoS5BLKqRwusCKggjNvceHlteW9vNBNRZD+tsSMGS0k4db0oP9zWy7dQt6gRYetEwGKhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQyaIUSLTmkMlKepYRvxVh6YxHxlESclCVztgfzwMyk=;
 b=WGNYYLkXzg0a4xqKH2ODvsXEjpAzz2zTho9GiGkEgO2GK1vaO3ydfT3/OCUmEITfXtBLRPx3TxiigYewIu5ZV9b8p6ahvktNNd+GgPqSyGRLEtAs5VmBlPBKaUIqdEidZDMIjKa34BPuB2ZRqWrXbJirp19V2ByxAdfOGaa46aFwN09IkJ89UycIYnCwpFPsKQnqcN7t3j04LLR+GT28tNEGlZOzBDPLyZ0YYTdjbmyEyPlMyTFKUKrUHztqqzAjatooBGUnvNGjbfX+WPaVatwDtStjuRaPpJ+axUuG2A52OzKOz8GkAygp3cIgUFwEx121iTMJ5wfg5+AeTTDZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQyaIUSLTmkMlKepYRvxVh6YxHxlESclCVztgfzwMyk=;
 b=w0cfaRn1kWc3q+L/5e9WEEwyIz+wrjvWa9wtbiBlFH1pt10D/GGCX1ezceCS7imPcbMgKhL/uD2iAjn2cpAkQQhLSPcEaCfnF4JE8bNAA/YWwODL9mCAhcO8ncsWjW9C2+ALWyO3dNS1QVg8JxRUNaqAvqbqOZJVkVk4NdE/Ymc=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 20:25:13 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 20:25:13 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Li, Roman"
 <Roman.Li@amd.com>
Subject: RE: [PATCH] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
Thread-Topic: [PATCH] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
Thread-Index: AQHXzQFAlMVXuFfjnkuqY91Peg1CJKvqanEAgAABYQCAAAA7oA==
Date: Fri, 29 Oct 2021 20:25:13 +0000
Message-ID: <SA0PR12MB4510CC0AAA3B6AEA1DFF197CE2879@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211029201156.17595-1-mario.limonciello@amd.com>
 <CADnq5_PJ1W0Hd72yiLrZAq2t4WkdvkhNJfwohd22naJ7h=Tbkw@mail.gmail.com>
 <CADnq5_PEzdQ7EREkQ=LE1P8L1cbAESxmAHg1FkvkBhpE=FDDwQ@mail.gmail.com>
In-Reply-To: <CADnq5_PEzdQ7EREkQ=LE1P8L1cbAESxmAHg1FkvkBhpE=FDDwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-29T20:25:12Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3a4d5912-f815-4750-a4f2-a26f3090ae63;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6591bc0a-5b39-415d-01a0-08d99b1a36b0
x-ms-traffictypediagnostic: SN6PR12MB2687:
x-microsoft-antispam-prvs: <SN6PR12MB2687726916080330CB17A7E3E2879@SN6PR12MB2687.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1fxAQp8PEo/wdp41hgVlMAa/KGhX0LRdJ0nEJC2GzVaSAL1rt3dOvbe8/GnQFXOAq7G6W/oVhEHSX9qhWQe/aQQl1ipddBr3WTqABTmYP71L0E5Dlhw8xcgGAyv5GSnSfCNVScmNQgNfsvqGfg0Wt+i+jk+MpQdpYBW9PkXktjIlHta1q4lOfyBpGKuuu+gE7iO/n6B1B18fNuJ4XYEPLFyw/y6Ey4QQysg7rh5PKueiVg7p0wKw3JnfsaIvMSfyIPK7YsOqdPs/DprJFX3/HM61aBE9n7von/y+RzmXUdsfZpX7M5sKestqs73tklJF1ZF+13xGYNDcPGSPelgMfAmWENkMxRL1q+VfSYzbhYwxBww4JsBhtTvEa/IUpUHd1zy0xVcOlTiEHmzPTcWckrSjYxWuwyglwyytnxLQ5+1LIP483xc7jWz2khKuX8UGJEEQmXQDHU1Q+X82616TfiF7Wm9jzp2/b4oWVyI5ZTqqzzQABwSiGw/YeoIuOzpHlEo7LEPZpEJeTZjV2QB7gCHnEi2mLT3GcN3o2jhvpy0xmcivBuhJajw+ObmZtJZeIppLa9a6oAEz7aRXHAe8cxSQ1yb1eC2HHPclQU2a/jirLft0mHrtSu9mzF+hAzL3jQd80A67Wc2vBwvRYMfmeDHEeVjBcQTZyMrFvblgzbSci6vtDC+eZzN78uk/bHwoLvaPrQHoJWP2fbSQW0fk7j0MQlMyNpQj14njX3/vl55PyrL8FZH8iKqy71Bu9Qb2IlriDDXqwlM4GIlRz1LoIiJ52h85IqPVIw0w+hJTFVM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(7696005)(53546011)(26005)(66476007)(966005)(6506007)(508600001)(2906002)(66556008)(8936002)(64756008)(6916009)(66946007)(8676002)(4326008)(45080400002)(54906003)(38100700002)(33656002)(66446008)(83380400001)(122000001)(5660300002)(86362001)(186003)(38070700005)(76116006)(55016002)(52536014)(71200400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Puxq80Qs5HTQKtC/uMQcIDQw7VW6Da/zOhuzzDQBoHNhTV4tDFdjefyd6WY?=
 =?us-ascii?Q?r58TbcBidjuNTdgajwR7JetEoLPg54aCV4qmbLFvqgsCvQt+b3NltFsGp1UJ?=
 =?us-ascii?Q?mVXNSo5JjQ8Zid+XKHBhZ7TJD0jtFtNo7DFvOwQ2KOEuZSdyQ/7lbIqFhSCi?=
 =?us-ascii?Q?cy3yK0/viWSa2A+vsR1LdDYN+yCUn1iKxD5ZUq6cZWuIE1m5aTHI+sV+2QeR?=
 =?us-ascii?Q?J+AnwIV3WD3D7Yb2dI6InV5CczN3wpwy5xCdp4ZHpG01Xy8k+GUdkX30kfWb?=
 =?us-ascii?Q?M3e/1lRVVRfMqvSA+bYK49Jpp/l0JcIOS6ysyh7PW/bhgaNjYm8EBse61+C7?=
 =?us-ascii?Q?W+LA1KP99A+aHLAx34QKuDcEPjRMqfQMuFm1e7tSXSLGQMyZKj7lCgCSoS+o?=
 =?us-ascii?Q?scnlLksC/lpbhGm3oFCzeoE2y6j/d+LIMYWspXaE/lGzbExjGeqM/63ct4kS?=
 =?us-ascii?Q?cq1MefEvli9WT5xmbG8BTwMn97EtDCpeibG1bOXEArUyvE+0EoyneocWrAYt?=
 =?us-ascii?Q?AhLwj3QzDuDgexmsk3CBjteEazkjKiP8ICLXBRUiiMi4uF3TOiHnDVYUYg9H?=
 =?us-ascii?Q?W96XOz8JPNpj3N0TlvLSS5CSxDmyaAqLVhJunlSSMoQoGhRstmrJqZn3F2pZ?=
 =?us-ascii?Q?Mb90spK9RExE6YspF6IMPV+BVrULtREYvdLIo/v6drw1j7kKtPcRMe3w34w/?=
 =?us-ascii?Q?qAJYerFs79dIXDZqKSUpwLLQlKCn9YCYlXnchCI+SjpkO8EW22IH84Be9Ok3?=
 =?us-ascii?Q?WU/rYBgr+HE3Jn1N2gO/1ESFVOdblZQcqAgzJ+VprTt3a3iYFa5BMzyH10Ds?=
 =?us-ascii?Q?+Zh2PPztejr/P2KVQG6BaO9HNugAzJ4nXatSHFIvxwaVuuNZdHnejJOQVT0O?=
 =?us-ascii?Q?Ory3w6j5VKBOX3SfdZ/Gzhc68Oo9GyuY4G1MbU35vGsY4QX6XJQNXq5gp2ui?=
 =?us-ascii?Q?uYPoAAsmlVxUC+7rZfkOi6CUbYSCiIYjoObxxmpNsQsh5m2k1ruo4ASc4XqL?=
 =?us-ascii?Q?dig78Trr08xzUKtS3Hr3wyFMf7DIoHbUI3PcvwA9BQPkABXc3sX9/S0bqE/z?=
 =?us-ascii?Q?PX4g0Y00WHdwmCUsQkTM/IRptUseS9ibe742IheIkvihsUBRrRmsmg/8Bsmv?=
 =?us-ascii?Q?LL5SFF+xXAVHGB/jyQFX8G6ujr3opG2zy1xcfvEigYt89WfGnqKbEzhR4B0P?=
 =?us-ascii?Q?VPLCg47oKEOrXtBsq142v8EV15BTuneG+RIp+VP0QibSnSXSJFG6msZFNUcS?=
 =?us-ascii?Q?66lIcdIdwx/VNJjp7JEFuySU0tM2S+tHe5cFBnymksqtxL/MCuYKRU3uNZ5G?=
 =?us-ascii?Q?aL3N4ngaPWmSv1JfxG/5YEQ2fq83/KVcMsde9rsrhDiblhI4kS5iHU6Ybe26?=
 =?us-ascii?Q?Fa4fR2o7VlGNJ+ffMxjvATziS/jFrsyZZaTbHShD22GnlN+zpn0nPWWkoGW6?=
 =?us-ascii?Q?Gy6BFfoVsj6baODviY/ZMtTj9s+nM9S6p+7SyPGIbDmULBH/83OkkzFyfV9J?=
 =?us-ascii?Q?VGliMLMOqXJTonyNDhKBGBl2H9Np0JJmEYZplr0/fGL2xQuZ4ujyhZ1gXIuI?=
 =?us-ascii?Q?Zsrm9G3IjPCq+pnKoMtX8HJ6jiYLxuoahDbqvYgMryZrGPw8ulq9ulrr51TM?=
 =?us-ascii?Q?86wfdZ+YggYzf1hkSCHYXhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6591bc0a-5b39-415d-01a0-08d99b1a36b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 20:25:13.7440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMow8ncQpKyoMgwsh+v75rNRsct5XK8IekQhNzUXJq/2ZG0jvawJDlf5DTKC61+URg+ebLfkY0qAB+Ub/Rbs8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
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

[Public]



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, October 29, 2021 15:24
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Li, Roman
> <Roman.Li@amd.com>
> Subject: Re: [PATCH] drm/amd/display: Look at firmware version to determi=
ne
> using dmub on dcn21
>=20
> On Fri, Oct 29, 2021 at 4:19 PM Alex Deucher <alexdeucher@gmail.com> wrot=
e:
> >
> > On Fri, Oct 29, 2021 at 4:12 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all d=
cn21
> > > asics") switched over to using dmub on Renoir to fix Gitlab 1735, but=
 this
> > > implied a new dependency on newer firmware which might not be met on
> older
> > > kernel versions.
> > >
> > > Since sw_init runs before hw_init, there is an opportunity to determi=
ne
> > > whether or not the firmware version is new to adjust the behavior.
> > >
> > > Cc: Roman.Li@amd.com
> > > BugLink:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.fr
> eedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1772&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7
> C03c84193638144254d6f08d99b1a147c%7C3dd8961fe4884e608e11a82d994e1
> 83d%7C0%7C0%7C637711358602513049%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=3DfrHB0cKKTUHWxj0t8kFBBYTlGapT2dpqUOddJyuPeZ0%3D&am
> p;reserved=3D0
> > > BugLink:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b.fr
> eedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1735&amp;data=3D04%7C01%7Cmario.limonciello%40amd.com%7
> C03c84193638144254d6f08d99b1a147c%7C3dd8961fe4884e608e11a82d994e1
> 83d%7C0%7C0%7C637711358602522996%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=3DdOqYHWrdTNrJdqdTL1OFJHJVY8ntiLG%2BJzWSqGLSn5w%3D
> &amp;reserved=3D0
> > > Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all d=
cn21
> asics")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>=20
> Actually if there are version differences between renoir and green
> sardine, maybe we need to bring back the old logic.  E.g.,
> if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>     init_data.flags.disable_dmcu =3D true;
> else
>     init_data.flags.disable_dmcu =3D adev->dm.dmcub_fw_version > 0x010000=
00;
>=20

Good point - I'll respin for that.

> Alex
>=20
> >
> > > ---
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index 6dd6262f2769..85b3de97f870 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -1410,7 +1410,7 @@ static int amdgpu_dm_init(struct amdgpu_device
> *adev)
> > >                 switch (adev->ip_versions[DCE_HWIP][0]) {
> > >                 case IP_VERSION(2, 1, 0):
> > >                         init_data.flags.gpu_vm_support =3D true;
> > > -                       init_data.flags.disable_dmcu =3D true;
> > > +                       init_data.flags.disable_dmcu =3D adev->dm.dmc=
ub_fw_version >
> 0x01000000;
> > >                         break;
> > >                 case IP_VERSION(1, 0, 0):
> > >                 case IP_VERSION(1, 0, 1):
> > > --
> > > 2.25.1
> > >
