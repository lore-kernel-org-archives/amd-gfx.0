Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569B7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 02:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E5F10E1B6;
	Thu, 10 Feb 2022 02:58:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D6610E1B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 02:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbv1nQGdjIeXfmbKL4MsyyygxQZyx0iGcg9EU5QQpcO6UOtQ3ir2o46T2ybPS+wVefbEyF52g/89dnyFJlErtg57aFYsDGqfs3npFtBRh31jvJZY3io5baMLR/h8MCSDzJODe2UabQhNDb0CJH67AuBaltzrLmtUsBQeZijHa4Mbv2DKBK5tPOKZcyzrDXjoomFCXoJa8MGp2s1k0037crUg+5Nby9HMRwu6IA66NM00s78HWxr8TDcnIYkaPH9fY1xWsOblQ4zWaP21qx+otNd9hxAmotNjC1XoeK71w9AmyvmwfOt/8C+BwGiDt3dvJYR2XW3y8L8st74ItlhJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqDZPdD0WK1/gBWvbX4gWCQUNxSFCHNthJln7NB5IeE=;
 b=TvL17FLPYcoU8gKuLojPYg1wG+t6ujtv6SBY+fL4vAwlyjOmEKZWQQKOL1UkUpwBxiEdwfRzwIWPG3EzhDx2b/uAj9wtqfHFDm+jHG0AtSz4D/Va+0LczUMXKcqCpVfR1PnAyCEyphyaC0+ZeSv6psUyTEh0AyF0D4uipr8rIlRmyTntKnkEMmg3wQ9u4DBztsDJLmK4/Tui6q3BWd5nt8BPm0qXz6wYOiorR4+y2wJDH+CgIEcijKIFEWGo31g6EHel8rYulLGpSAEnqvuKz8Zbu7WDzBRxv9a0O42INQrvVWtPyfHGVxcE6QdQyDTWuopRYO++xkyvotaZCxBybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqDZPdD0WK1/gBWvbX4gWCQUNxSFCHNthJln7NB5IeE=;
 b=z5c8EVOcXfD8t5DLF43uMbiE8Y6RIX+OpF9paQznX27qbvYoEueKnV71PLx0fDXuzW5FEgcUpXzVEp91Z1/TrbqQ9C1k6PScLUTmPFgiYbM5PBvzS8dVg1ZU22tmoGya5hDFd3tz5NxGRxFn1w8gSduXgJKKzpFftcLojjLWT2c=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 10 Feb
 2022 02:58:32 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::39fb:d4a9:a0da:334e%6]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 02:58:32 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 03/11] drm/amdgpu: Optimize
 amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
Thread-Topic: [PATCH 03/11] drm/amdgpu: Optimize
 amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
Thread-Index: AQHYHXoBLfa0SoM5AUmM/nRO/li4layK6kwAgAEs6UA=
Date: Thu, 10 Feb 2022 02:58:32 +0000
Message-ID: <CH2PR12MB421531EBE2D44382D2E712AAFC2F9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
 <20220209055644.1873011-3-YiPeng.Chai@amd.com>
 <DM5PR12MB177097DBFDF292BAA390B8C3B02E9@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB177097DBFDF292BAA390B8C3B02E9@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-09T08:54:17Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f99db08d-6001-4c76-961d-99fb74e09471;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-10T02:58:29Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 263bdc17-8b97-4d9a-b97d-d69a230563a5
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67ed21ab-9d19-4518-98dc-08d9ec41395d
x-ms-traffictypediagnostic: DM5PR12MB1947:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1947EA8BB3A2794EB3BB5B73FC2F9@DM5PR12MB1947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESPm5zkw23U9x/BcM8SwIlXuRkR4dM6M5J/WEJ5nu+Z8enCqqcYfXynEXjslIWsuQJ/5zqHAR96iB+ilggCha6RObTUAwJImO5l9guV2q9OwqDwqggfVsvzjdYcCsVIvLhpS5PpmHfTLUuqIouLUJLjPB1mALP/cX2623A+NTT+swxgBVd31QN5IkWPs0OXOoi0yACmIEwT0CL2uLAFP+rvlhqzsIsD+cDMqqqfdMOWweCwDVOIcJivVytap2Sg9jysTidR2EtA7FHyz8sfFzvOUNYqRSQ0ry98TQDJ226veaMrbMsLqXiJAfRxGzZwLbmGIx0C2UIgLVtZH4gSloWI88ETf2rj92DOPheavNmS2rYE2mTWZ1fyJQeEV3TWVifzjXCoN8VKBsWgQR2NWOTS2CxVzWhjmNsQY6+FBMi2XdquUhkzHfD2puegAVC30+vmTX9QGYOwv1QLEBlAJ4afodTuWHHZLWP9LxE0ArZgPlZUn82HEuothQ+UPa6DENJa1Gt5ckphzDxaeKnIM+U6VoSlayNrOI5ZFSZKjAVvAAoqDEyySrGK1VmszN3m/3Ltm4Lothf79TYDRQMOU9BmdNvV/AsTOeAfIohY9ncMn/bq11/+7DOj+IgZ8/ukfzbs15cwquprzKLZ8J65owPCkigmMkBov1hH2dWXAnIjCL6rnVC5IAxYeUzNFi5J/N1DFcTl7SyO/Umzfbhuptw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(66476007)(86362001)(76116006)(66946007)(66446008)(33656002)(66556008)(186003)(110136005)(54906003)(38070700005)(316002)(5660300002)(4326008)(7696005)(6506007)(53546011)(83380400001)(2906002)(26005)(9686003)(38100700002)(55016003)(122000001)(52536014)(508600001)(71200400001)(64756008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OQ1KkqVswpzo5VVCqibXqtVI6m2CGcOzQbz9ud+BAZhQSUHAJTerBsHTpewK?=
 =?us-ascii?Q?ASjgdoIG9Kc2l17GFd/5SMLosRBoEsbSXr8tI7yY3zvgzNDl0zy5uQdbkbNr?=
 =?us-ascii?Q?heWgFprhMANYapkloW3CiM4qOAm2dIU1lSpeaaOVMuRndbPjlKpcOuhVw4F8?=
 =?us-ascii?Q?wfBpnBgSsIvYV3Oo54Exu1P0jSBiwEbwp5/oRf1Xmyun1MqbfwwIft+gTYmX?=
 =?us-ascii?Q?ENaaHShiENmyqdN9sU/1gHpqE1x3einPVQEtOLkLG2ay2jYPaHlEQrMXbTSs?=
 =?us-ascii?Q?v1+q0QcJIYpX02hTdX7sGQSdexkxrfjMCQ/FgnXt/LLRiTCOmVeDGMk7VGMF?=
 =?us-ascii?Q?S76aE+pdhvdeKeLXZmznPm3p+TqQ5/+S4zoaIFXuZhwZr1W/Ku5Oiu00Gvb2?=
 =?us-ascii?Q?9N+ulrC5qFwVsn0DLLQ/d5Ocopnl/fFzSPMtw0wlS5YfinGyDyIFXzne8+aN?=
 =?us-ascii?Q?TkOsspLopIwi1jbfB1EReqNGcvXkbMGKQOBxFUC2OurBC9lCrcN4rDHo1eLA?=
 =?us-ascii?Q?oSJC7CQhK7sqUvKlRh9T0TyTb3o8H2SynvZM8pZPbp0LTiwQxsQ/U+uASF3E?=
 =?us-ascii?Q?9FD9RSvBf7OLGdDKj23J/BC+vor+xN6SSz/TER5LQJTR3ToWhEO2Rbqu2zxg?=
 =?us-ascii?Q?J/Wt2xD/ylorw+95ca2ID4zAkcLaRZPneIkxZA23Dr2JhyKwfZGvdnf44fgR?=
 =?us-ascii?Q?sCj9/sH4fgRERS7/9yHESETkpwIUCMpqm1pEZHhQbJ8RTMcyzuYhke04lKTn?=
 =?us-ascii?Q?ellqIYTqHPuGzm0wHLv3UqAhMN2IAt3708cMsUvQAN6JynI4kd51kIT2Y4Do?=
 =?us-ascii?Q?pqqIK5qPwnO1sNwLLwv5trWzpaE8+km0h2LyJkzsX/jPV/s7jYWLGlUyjSXM?=
 =?us-ascii?Q?Nc5/ytWevgdaMrcWviO4lQFBpuXn8KGlL/ynuaAw0sPVjz8EyI7HjXANZref?=
 =?us-ascii?Q?9B9XvJPHWvdIwgdBj8/piW7o0oMDJjhwyJdhIFoqS4bXCXUUfRSed9R1vqni?=
 =?us-ascii?Q?SywFXYNUT467FCKLWyngtfhEghcc+DLmq0mjJPBOmoE+hcnXeB76227ED58D?=
 =?us-ascii?Q?Oy9DNQiGdq0BGeX8e0jLjce/yhKmPvnG88zLwkb67TcqRCo8vkxw/+cbx18c?=
 =?us-ascii?Q?CqoEsmQYDjiEFXEhc5KVNQzaHdEa+yS4KCoZLpb/l9jm1e3+IX2hk2/+9HF7?=
 =?us-ascii?Q?O7DIiFcdB57lA6p3t/ImjEQmo18H1OzDil8YAfuac9giRHgDZHJmXNGELGPX?=
 =?us-ascii?Q?vPns8E3FUWBb/zHOIZdlavw/Tk+0B0miFa1cR+Tg3dFs4uv+o0Px2Y/W/z1l?=
 =?us-ascii?Q?bfSnoyN8GG2XuYh+g1Yonhf2xu1exOyLc/+tHVx7P8E2fRvqk9knHkPb+xbQ?=
 =?us-ascii?Q?HcDDUzJaYqD7H5nm0wHK5JfIzzyGw/GlAh8QXsTIaMxM6jr5fzfXXKqNSRrm?=
 =?us-ascii?Q?76/j1FDBL1kDbS4nskc0+1xPteDif8G6dKsvum76Gz3VUg/4U8KVf6VhQ9oJ?=
 =?us-ascii?Q?Ln6id8Fnkw916h/PZK3KPsLyBgzYSOvt1crCkk8jtljDjJTyqpQcj3/sT0oX?=
 =?us-ascii?Q?KgG4W7uIrcjYXspKB1VL/XGeNB48FEOcmeREAl3ZC67wEHeWdNsKMHdoxEI+?=
 =?us-ascii?Q?iUS153pw1siF5WpW5r5g2z0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ed21ab-9d19-4518-98dc-08d9ec41395d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 02:58:32.8007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVWjG3WjZNB48100B0+dxclOaCS8pFV252iztC6xtqu04LXZGZqXPWxjN/R3dFhGK3QPD6bnu3EdsOET+WCXQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1947
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, February 9, 2022 4:54 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>
Subject: RE: [PATCH 03/11] drm/amdgpu: Optimize amdgpu_hdp_ras_late_init/am=
dgpu_hdp_ras_fini function code

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, February 9, 2022 1:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,=20
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 03/11] drm/amdgpu: Optimize=20
> amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code
>=20
> Optimize amdgpu_hdp_ras_late_init/amdgpu_hdp_ras_fini function code.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 37 ++-----------------------
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  1 +
>  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   |  1 +
>  3 files changed, 5 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> index 518966a26130..21a5f884dd2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> @@ -26,43 +26,12 @@
>=20
>  int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info)=
  {
> -	int r;
> -	struct ras_ih_if ih_info =3D {
> -		.cb =3D NULL,
> -	};
> -	struct ras_fs_if fs_info =3D {
> -		.sysfs_name =3D "hdp_err_count",
> -	};
> -
> -	if (!adev->hdp.ras_if) {
> -		adev->hdp.ras_if =3D kmalloc(sizeof(struct ras_common_if),
> GFP_KERNEL);
> -		if (!adev->hdp.ras_if)
> -			return -ENOMEM;
> -		adev->hdp.ras_if->block =3D AMDGPU_RAS_BLOCK__HDP;
> -		adev->hdp.ras_if->type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> -		adev->hdp.ras_if->sub_block_index =3D 0;
> -	}
> -	ih_info.head =3D fs_info.head =3D *adev->hdp.ras_if;
> -	r =3D amdgpu_ras_late_init(adev, adev->hdp.ras_if,
> -				 &fs_info, &ih_info);
> -	if (r || !amdgpu_ras_is_supported(adev, adev->hdp.ras_if->block)) {
> -		kfree(adev->hdp.ras_if);
> -		adev->hdp.ras_if =3D NULL;
> -	}
> -
> -	return r;
> +	return amdgpu_ras_block_late_init(adev, adev->hdp.ras_if);
>  }
>=20
>  void amdgpu_hdp_ras_fini(struct amdgpu_device *adev)  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
> -	    adev->hdp.ras_if) {
> -		struct ras_common_if *ras_if =3D adev->hdp.ras_if;
> -		struct ras_ih_if ih_info =3D {
> -			.cb =3D NULL,
> -		};
> -
> -		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
> -		kfree(ras_if);
> -	}
> +	    adev->hdp.ras_if)
> +		amdgpu_ras_block_late_fini(adev, adev->hdp.ras_if);
>  }
>[Tao]: Since hdp_ras_late_init/fini are simple wrapper, can we remove them=
 and call amdgpu_ras_block_late_init/fini directly?
>The same comment to other blocks.

[Thomas] Compared with amdgpu_ras_block_late_init/fin,  hdp_ras_late_init/f=
ini have different function interface parameters.
                 But can do it as a new ticket later.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index af873c99d5e4..b12fe6703f02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1302,6 +1302,7 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct=20
> amdgpu_device *adev)  {
>  	adev->hdp.ras =3D &hdp_v4_0_ras;
>  	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
> +	adev->hdp.ras_if =3D &adev->hdp.ras->ras_block.ras_comm;
>  }
>=20
>  static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev) diff=20
> --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> index 503c292b321e..a9ed4232cdeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> @@ -160,6 +160,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
>  		.ras_comm =3D {
>  			.name =3D "hdp",
>  			.block =3D AMDGPU_RAS_BLOCK__HDP,
> +			.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
>  		},
>  		.hw_ops =3D &hdp_v4_0_ras_hw_ops,
>  		.ras_late_init =3D amdgpu_hdp_ras_late_init,
> --
> 2.25.1
