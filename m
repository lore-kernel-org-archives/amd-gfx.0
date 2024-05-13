Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924ACC25B5F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 06:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F8D10E183;
	Mon, 13 May 2024 06:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IT7UICt8";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B7810E183
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 06:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk8m26WLt5SqNQwn6asHTLAhoz/ly3KhY3BAlUTNdPvFalek5kgyZ1oRIEW6hwBM9VW2r+y669NRSRtLuu3cpDNO0Y67rN7lkl7Dqkm8CP6yjMgj2TplPVu+tcX8YPyeeszTas/8ccvFyMq2BMm2Fojn/a8WrDS/cVt39DKaDlVklDJ4bubLPsxI8wA3n1WrUsM5nGeyS6dZrJSJcNR3daeP4xV12xrtv3lqrEIDCXHqgGGRBIthKkp+oA0wOGw4lFDbdnYJflnQT3NLtIf2u2r38PpUE6zTHkVH9nXeJKbjpvVhCSVtPpQiZJioev+ov2EH8nCTkTDVVB9prw4LUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88Ri1UIkuGKdUuEU2gMZNiloMBPfgvoaetC2RI9w+SI=;
 b=Sa2isL3oG1m1Y2wtOEwWYvHCA54/MsLK5Xiv07ctliBZdw+IBClPYwXbQ54WXl+hGUMxQPKIypjCw/rNWTyPo6otoW4gqroW5DOvZTC4YZX+HSbIPPatxmvg4lgZhQxvd+Fs5hs2OnMDtomPQpJnWUvcpEqkuUSjLnPZC/tZBwA3ABanTk/vOm/lZyLbs+OJR9Ob41stHvnPi6V18HprJAU+6d9Va5spYW5FZlwzbcq9i+iX61s5XZrpqtjQ9S6LT8ULQUjw2lfakdmUkiYOXZ16jLPUp9SivpJnJCK4KUsPOk36UsFPnpinNKWpzF/1G17pQ+AEBsDOC4ebkqnczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88Ri1UIkuGKdUuEU2gMZNiloMBPfgvoaetC2RI9w+SI=;
 b=IT7UICt8wYrDT1Q2aOUa221duq8YO+Mhasc0odzwJjBZJTGxL7aQ4GG7w40vGvTGmVMALqOVzj3CMWZftQIQn7MEnEqERdAf+q0xafidSetjPiqyu0NAEqcbM8IVZ6TDsBzRhQWr3chzVuJVj6YL7EfefZLg9axRv45q2Kpn5J4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 06:29:58 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 06:29:58 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for
 nbio_v7_4
Thread-Topic: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for
 nbio_v7_4
Thread-Index: AQHaooTpk6ppaKx78kqRDqg8NF+tYLGUcoLAgAAi6QCAACM+YA==
Date: Mon, 13 May 2024 06:29:57 +0000
Message-ID: <DM4PR12MB51523E17082B7AC794E80EE5E3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-2-jesse.zhang@amd.com>
 <DM4PR12MB515226FC7F4075DAEBF4197AE3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CH3PR12MB8074AB04B60B2F902E41EF64F6E22@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8074AB04B60B2F902E41EF64F6E22@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=00c36985-9675-48a3-952d-01f98ca7c697;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T02:17:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB7382:EE_
x-ms-office365-filtering-correlation-id: ef906ad8-9f5a-493d-1926-08dc73161c39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?vd8rf+6T1RsS7t2y9CBmLVCGCxZP0Ge2TYio9srtvQUp/NjY9TfkAtGs0zgC?=
 =?us-ascii?Q?+lxILpgiHWYcj38DEqJEAxIX5OcaDth3dh/pN6th9Kb1Gh+qKNLu+vjUqrn9?=
 =?us-ascii?Q?phAu6b7zWfN6Hsx5AnligPf3FSMMK7bFaGKSZVn+2TD4u9PnBwC6lamTYkE5?=
 =?us-ascii?Q?8hUadjzD76Ki49zp4loBrSOF/DDzNx1k7V00zpKLY5KwP506ZW2HwPH1d1es?=
 =?us-ascii?Q?lS9GB3JW3/pSdXy7jnKbd1sevbHM8IlyqHZfFlUMHY5Z3DQOdEhUkktuIR0L?=
 =?us-ascii?Q?IOEFsS79xJ/NEB2+N7yk0cbRHNsNkw5OoxQvNRp59bwLdkOEee7dFStn8JQF?=
 =?us-ascii?Q?TXnsyuGXP54u3iUyWQ2ZUhjR2jezMEFn1ahXRprfzcMYk7C1MGiMsVblAJ2k?=
 =?us-ascii?Q?YTarCXKPj7/irlajVkpNURBCmw1QbsuLH4kqnCKbASYSE3qz4Q20sF24I3AX?=
 =?us-ascii?Q?iP6YrP7r7P8RUXdma12TAM3f5GoK64w2VOdbwCL7UDQRRhbJ+x+9MC8O5XRA?=
 =?us-ascii?Q?oIWckY0qSAC/mSessCwBPGGl1knQctPaHT2lP4PCYXeasEk09avV1TKejD/L?=
 =?us-ascii?Q?rrIsemwBsOyE90aTPUlCXDlygaiNi3LhDaWK37/vjR4kor2IW1qQ51I4UHMa?=
 =?us-ascii?Q?UonRDTVwtg7HLb+WxbB3ZPc6OnEWht6a/nLgVorhHlBciTUMKTWkouoY652h?=
 =?us-ascii?Q?Z2tuV+6ZlnRqEGgnZQfhxUt0bE8PAH5H5nfcsN4cX7QRxFOwhHD+oJKEyWBU?=
 =?us-ascii?Q?Zfm/jALM0rtr4AenCv5yhj4MFXil7DlXL3AaD7YQaSRt5+R5l9pBCj5pI1Il?=
 =?us-ascii?Q?01NI708/sIfc8GNudb6/AwYnqF/Y0lTxDWjROxlC6F+I6Kcu9NnCTAvd9dIa?=
 =?us-ascii?Q?jk0p0bdFUuRYx/nosJmbCMvkI7lBOsp0doyMVmsN5x0F5WFg5q+iM2/J163N?=
 =?us-ascii?Q?z5M67IYGl4GcPGvZKJKwmLihDluxLYFfShlpcT8UrS96H5HO3qtWLa9ly1mE?=
 =?us-ascii?Q?UvQRlppkHjyjZSe65y5kikZmcEZlaVlYIvW2MSkYAW46/bhvh8N54NyZc/HF?=
 =?us-ascii?Q?Q94PMpUpNJw7gwd4VM8h397bA7GQ8spWIM5d34eEWyeQgs3oxwETJ2cQY0cf?=
 =?us-ascii?Q?PhRq7aalDrIAAyP9/jtFNbFI38tkeeoeQYuZf5iiMxzo3IwP+2m1VS3PbowM?=
 =?us-ascii?Q?+dvUVUsnS+OwhX1Qzc8pFiBPxsu696IuYvVZ06UsSqUwhyH+HsI5MRUKdvLW?=
 =?us-ascii?Q?J4emHRjsJetRPs8uZFmU6iRI71cFYVFD6NaguFOqJweMCAZNXBMkmM8XYV5W?=
 =?us-ascii?Q?/21Byv5MP/5Vz9VypYbP4DrVt5XE91MzsM6xzvj3IeZdHw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?52iYlxn3XhNrPkR2pb3UCq4F1dV9hdau0U6iPxLkSaPdQnKBEVmwr05TlvBc?=
 =?us-ascii?Q?JwFghBu2B9MOXTN+Hv4KuvznlXMCQ6/1qY+CEeGFP/HSLIsIGOHmn3i5WhRN?=
 =?us-ascii?Q?5W87WMtSc55pagBCxxCWV48kKOVNCM/6ZTUhSqqlygsAjMtAkuZlIkPctiVP?=
 =?us-ascii?Q?MD6WzJWc7Lp4OyX2fSe66H+oKj9qKbg1g7IsBuI52ASGSDI3/SFeGDC/OjE3?=
 =?us-ascii?Q?9oO0pX6Bst92N/wNMz7WjW0bsvCa2JBil1Kqq1DoSyHaF1S9rFNK29+AKG8+?=
 =?us-ascii?Q?XNePUKBfS77O3IFKcT9D1z5LEmM8CNp/3PtvunPs/O9TxSPjtcKxt7R39TMl?=
 =?us-ascii?Q?9Y3iKnD3OxU6cIVLaWPCkNYtTESKwDJIVxkic/Gvjs+tjNkHzXtwEBI3yeih?=
 =?us-ascii?Q?ZDZRBDX8AkN5HljiOIKRefSOZpmNu7seAtqJxzbeE7az1v7+qx6/u45pZlM1?=
 =?us-ascii?Q?xbB83cu/EckMF+CEU/zbhNJd6XLsFQMg057rX+oUdd/Xq8/WyayQhETc78q6?=
 =?us-ascii?Q?/q75noXNv6HX0laAWD0nuiXD54ojSTPYMXd84my8N8udEMDGBOr9NuHSTRgI?=
 =?us-ascii?Q?ZkwE3072IXjDuRvMIf0/D51JpfOHPVxpDWiBQhYh7uROT9jxTCTm9gIBNpA9?=
 =?us-ascii?Q?lv3ueX5lEEirNRj6IfM7E4kr/BI+826DVOKiJ/5pmb+t7fcfkOxsTu5z8nP3?=
 =?us-ascii?Q?sxvQaacWGGQ7aCVGakpdsRwkGBbeG7iTCRhdETktIe/QVaYixQ4Efmtge8S5?=
 =?us-ascii?Q?oNbgU24wQcyZmgfFiDnwh+iC/F89YkG5xv3FnvdEFNTipetxxV0rEt/5e2um?=
 =?us-ascii?Q?jeMahEaZla5hQmZ18y8DLBBmYtptjwrTYZEkRbVIYbL01eqBMSR+2QtIaBIQ?=
 =?us-ascii?Q?h7FYIe8An/uMrxCPLDX7aV889SGztuWvQbQvKYhSgtI1D7OsnhoLEhfEclvd?=
 =?us-ascii?Q?WJQ69dXsnAvU6YOIkD383QcM4PUoax5TeNLvCg0GHghWsfolTJVimnwdj9IH?=
 =?us-ascii?Q?piHdAkrgnpb2Ccx4/ZwMMHW2T7uR/Rz6tHQOhb88xN/gs5Tk5mWW6HzZAbIR?=
 =?us-ascii?Q?AWfIKxKFiyWBIGCY9dk0UzvlgqdxxFXCrgdTVSow1lh9Es4GEz0qSNA5KKWz?=
 =?us-ascii?Q?3sjBRgrgcpAw8okY7e9j4xhGcmxSZQnI06U+wuZBnhw8w22h5hPW+d67Prcb?=
 =?us-ascii?Q?Wyb5QVnC4zzeCQzIOxeVuS1stg4DAhZ6ZfUYg/6iP/opZnCmx0j4/MWQSHmS?=
 =?us-ascii?Q?WIyWnOTQwkOBWnU8W8TOtjMstgefhUDXdhyK8C22aje0NuiYEr6KQSFH+sXg?=
 =?us-ascii?Q?DrTNY6f5BaFW3kh5go11OHRKFFMflzGVIG/GkIOM0ksIRIsCHVqf5GaXcStG?=
 =?us-ascii?Q?rkuTgoJH0PFEeva276wP1R3vyv5ROZToYmE1LwlhgAXGMplhagStJE5t+Lro?=
 =?us-ascii?Q?S4PZ3df1Dk0TT0eQfjMJHrBjrlVo0tmawqe2CqwBkob6BA3B+QWynNseJevn?=
 =?us-ascii?Q?MOdOf3eAY/aGf13ICC+70hpT3yxTlgCdApYF4OObKZdyhfqtaJwS3uAq5Ef2?=
 =?us-ascii?Q?v6jOSDb74LjVu3xEl54=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef906ad8-9f5a-493d-1926-08dc73161c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 06:29:57.9149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sM1n0wEck6SK/xXywogIOy3U+Kt+XBZLQKPVjgz03hXqJUn6S81G+XgcS4so9zI4qPLV5VzjQOnKc5W+C9lXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
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

Hi Tim

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Monday, May 13, 2024 12:23 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: RE: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for nb=
io_v7_4

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Sent: Monday, May 13, 2024 10:18 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: RE: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj
> for
> nbio_v7_4
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping ...
>
> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for
> nbio_v7_4
>
> if ras_manager obj null, don't print NBIO err data
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index fe18df10daaa..26e5885db9b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -383,7 +383,7 @@ static void
> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>                 else
>                         WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL,
> bif_doorbell_intr_cntl);
>
> -               if (!ras->disable_ras_err_cnt_harvest) {
> +               if (!ras->disable_ras_err_cnt_harvest && obj) {
We may need to check the ras pointer as well?  Such as change to " if (ras =
&& !ras->disable_ras_err_cnt_harvest && obj) {"

[Zhang, Jesse(Jie)]  Thanks, will update the patch .
Tim Huang

>                         /*
>                          * clear error status after ras_controller_intr
>                          * according to hw team and count ue number
> --
> 2.25.1
>


