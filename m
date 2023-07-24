Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB98C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 07:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A04C10E071;
	Mon, 24 Jul 2023 07:57:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D5B10E071
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 07:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIpkhlUigKHFCFcvnz9fzxCmGOwJDzLtkrA0s7LAkRn/On0LCWevrRGyY6y9yLjaHuyP8mzITJUwjCgCKj5gkRiL12VnyEExAXXJ4J79ORbwmsdCvYfePHbxyvs56P/Z24JAQn62LjpZ3CvBHxV1wk4ypQfTA3RUtKbyDfwAz/9nkrEWRK/f2PZRlBVO8UlBzBvUEwpVAUWKXOUPX2jgqIImbemurydUZAyGoOmOqqDZq/UUp+u+Ca5sdCGDI6kxJjtVAjwg/Uw5ArS2LCDml5ZzRRUmOLwOjXaPUDvqHolnev46IInCbycUVMFkThN9T35aySDjMSwfbMcGBkw7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyfl15TXmTrOIHzNXm6qA8Sr2m56TJWxyhtonq8b/ZQ=;
 b=CbnUBl+jkAOQN0/fGos/+r7qXXeXPs+h+vwzrp8to96wC6eaPUqNq64LxO0/GZhac/rVcsEGdq6RIWPScQ1KhMp6efUIqnHu7VdJ2MfPdcWrQ9ORrBui2171rILz86KObEASXdmxYMJ2yvWhnYbBnLpxRF/zPIHfnfiZj6hdl0258AaspC4Cn9pZbAU3lp4H1Mm7e9D49BmmWe6Uq9Ul6aycYAXjvgq0/kdYofRgqfhr45mtW8DMrxBIZgLBK2LYJyhjRVN8BKHFF+2u0RMl6L5+yolodwvvNTuiXuwYEXIn0i5Hfr/WhAE4wVe6pTM7ni+cSUudb6Fb9Q6O4osCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyfl15TXmTrOIHzNXm6qA8Sr2m56TJWxyhtonq8b/ZQ=;
 b=Xmz9uViMiaJO6EosQHTscCU4TCmzrZz9BUxkRUOk7sf86naXSSoDkkeNvrXs5rqP+orQUa0FNh3LBVXoXJEFciCKVIzHDM9On2YNCHgsSRJgniQTr/WnZ1jCK+9Wd5bv2/bNiSsfGFjlkyxOpvfVJ4wYSX4y8UKhhjqfCi6eZ44=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:57:49 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 07:57:48 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove repeat variable domain
Thread-Topic: [PATCH] drm/amdgpu: remove repeat variable domain
Thread-Index: AQHZvfoUe5PJGXP86kGLOrnx4KjWCa/IidIw
Date: Mon, 24 Jul 2023 07:57:48 +0000
Message-ID: <DM5PR12MB24693330ABE05C02F53420E9F102A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230724064248.447145-1-bob.zhou@amd.com>
In-Reply-To: <20230724064248.447145-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0145ad1f-1f14-4520-a047-bea7cdbda51d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-24T07:46:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|SJ0PR12MB6944:EE_
x-ms-office365-filtering-correlation-id: ab4db12a-19c2-4938-eeb4-08db8c1bac7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0co8kHOBBOWVdBZg1LpR8vN+1jE/LxCsSZ/MDUOLGQN6DdE/LcIOf1W7z0PLnVDYHC3Dw81nxS1cxSxGmE1UWqslpZpmeZy60Aph0ZWQYxwTxcGSHp866L8aUDGMjYxpORvxQFkAa3plTR27hrirTD9E0CCmTF7pv4HS/U3tkYUfmn04ZTsNPPrIJxuiAokp2h0n6VtGHzOYNmxn8FLGHULOSOKDozogLmYDjvIFkLFTNlTEo3VinBbNr9rZLSqJFCEUzxHpwwz7EEOx/0M8P7tr2dKMQOJsugrlMLJR4X5YiMp4kqVqyJl0ZVFTtwFBiJY428VWcY8STjh06G7eZDfgWxAJI/BYN0JoEznJUx+Ay5wBbNWmfstUxj4yq8pTpXaiUadSyGh1dD1s6LqFBv1X44dh4/SVChWQ0JfIuT2c0IXhln2+4keDMObxwr2D1OjDcnOC2OnBtk9skU0YdhvI5bqvZB6ApkL+z2qzev/33cnLZLmQjtkKAV2RSrPEXq2rDGvftFh1UlVi0sjtGlr164Z3Z1C12jrgjPfGzIpUxQj3YUffGkHqrxDJdhCuZZJnBnTecGEgb6oJ5OUoYoPqFsTcg9AqH/uFPQBegtHFHLd4SJg04rHd1ppTSf2p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(38100700002)(122000001)(55016003)(6636002)(53546011)(83380400001)(66946007)(52536014)(8936002)(110136005)(8676002)(5660300002)(478600001)(66556008)(66476007)(66446008)(4326008)(64756008)(316002)(76116006)(41300700001)(186003)(26005)(6506007)(71200400001)(7696005)(9686003)(2906002)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fVOoCYPAdw1X9lObBKNOvce6mME4vEHvekrHm9KCzVgpj2eizgrPfzHgGCsk?=
 =?us-ascii?Q?Ky6zn4UHsdS/KvlAmH07mAozjS7d+N6ycJJWF7VvvmfHDtkddencoEG25Hyg?=
 =?us-ascii?Q?IidpVzJY5JFN+ZwiyTHEPa0G399v24C1snYS64TRQIaoWyxx2sTEAoAXFEB5?=
 =?us-ascii?Q?XCkj2F61GoYp0fjZ40P43kI9A316FRSOH4qBpxwHIW3/mioM9/AE9E1ah3rh?=
 =?us-ascii?Q?e4bOghOS8R+oznUC1PHEF7jcoWOV+VEOzZrCsomyUJ0jcOtcv+317rKi82Gh?=
 =?us-ascii?Q?pvHymH0jeh+f24AHhAFcBVL8B2Lnon+P3uKJXQ0jp+DoHysHvo85lYTx7Asa?=
 =?us-ascii?Q?58PEpnBiIfWoAGwtn3KIfWLwpH7XX6FNbPScm1xhCY16kW8ZQqqT4cxqhvfe?=
 =?us-ascii?Q?3wVSiI/5r2uvo15BuqMY+6LiKUtNXOT9eBlYRqJDxOicx66bh1QQFIX6uSBC?=
 =?us-ascii?Q?Auy8Kexfw8BZbX/4at4YuUm+FswxIRHAu0DTME+/+9RP6NF1XDvFICiRLESc?=
 =?us-ascii?Q?CgRXeiBfDwla713T94KEFyaP6B7HJ9o0Sixa2wZwLEVY3IyUirbw4jyRAeu+?=
 =?us-ascii?Q?h0eBPWDV1pNk87Inabxp8FoXi0dRbhh1NFCbhJ0HGzLwWAZgJyMGb7z0D+58?=
 =?us-ascii?Q?XZEOPldGs6JXtTFC1+/5IL2GWwNAZdWb60IFhLrBOmjVL1zGAyWKoQZT/IwS?=
 =?us-ascii?Q?+qndXQPZzH70gPzhwYuNiSDMit/DSjO/2Q1BQluXNNWND9ZK3DoT5+sYxGcg?=
 =?us-ascii?Q?PNiwAUECe/Q7K4fPALYFNZ0M9ayKCoV7Jgk+rMNAFRzdGs9NmZzJqfSsms3x?=
 =?us-ascii?Q?GoV3Zu1wfrpBYRCLM1DJofgM8qZB6UNGudCUaGZvaLDrSUA6+lFZPwMohSeO?=
 =?us-ascii?Q?y+5KIeUWqnh83VTX5771EWzL7SEcKelpQhO6HaIF9kTDBB4DIJEIBhm2+Y7U?=
 =?us-ascii?Q?P9KAcAcTgTmilZYsVZcHXxIppzhWTsq2nip0S2c/liXLIbs+d9XAJCffUXPO?=
 =?us-ascii?Q?7cYUGOQRisscVPFuFXn4BuRfVloqNoXChjT9Ikxa/pWRkNA16pZD06KFXKBh?=
 =?us-ascii?Q?rrkxDGUd2QDPjcU/gjpMlO95FL//0KQ7QSWRkty0Cfc+knU7vUUCixrbxHtb?=
 =?us-ascii?Q?zL+YSqNbpg3/V06Q5HBhnEEr/Q5dPhAdNTYt3GFs68sEDjpd7uvTM5N4I0X+?=
 =?us-ascii?Q?Uu1szhcn5pW7byTaTNMqHwPNeE2+kUjdqIm281JzsBW92EsvPYjIZAVRS6qF?=
 =?us-ascii?Q?ht3+O5A+/GvLcs36CBmdXQrv2Tcz9/xVE4DhRtDfp64+q0fN4P2G8e8V4u/t?=
 =?us-ascii?Q?hHp+swqNA+so7cBMeBQs4Gf3VTjOQATwguSolvZDxx+yT/gcf0yfEEPsw50W?=
 =?us-ascii?Q?IJKZ0VOFsvpync09QTamenpYxFWbf/ghebay++jYyMEPiXb70UrxPBzHL2Kf?=
 =?us-ascii?Q?UVTCuc/aNUXJHSFfTt/qKQDxNcJ39+DakWoYp9dc7VV8RqMo6zfnGCM7YRdh?=
 =?us-ascii?Q?Wy/HKAQ+/IeVQ7PdfgHEjkBgcynJDGcEo9R/sE/8dRsiyCdmjv/+59txfvrv?=
 =?us-ascii?Q?9Nq9x+J00wbam6J5QJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4db12a-19c2-4938-eeb4-08db8c1bac7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 07:57:48.8800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dv4HSaKnvIgoydY3I7/wXDaY8U3LNdcV04MDNsAH5kwGRjl5xgsWw2ftXWFfA4M1uhUA/B2ybTzlLX+Vu5nt9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Please add a Fixes tag like "Fixes: d769528e4649 ("drm/amdgpu: add VISIBLE =
info in amdgpu_bo_print_info")" in commit message.

Regards,
Guchun

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Monday, July 24, 2023 2:43 PM
> To: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eric <Pierre-
> eric.Pelloux-prayer@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou, Bob
> <Bob.Zhou@amd.com>
> Subject: [PATCH] drm/amdgpu: remove repeat variable domain
>
> building with gcc and W=3D1 reports
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1618:15:
> error: unused variable 'domain' [-Werror=3Dunused-variable] unsigned int
> domain;
>              ^~~~~~
>
> The variable domain is repeated, so remove it.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 5ac7544cc068..3f98174fb764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1578,7 +1578,6 @@ u64 amdgpu_bo_print_info(int id, struct
> amdgpu_bo *bo, struct seq_file *m)  {
>       struct dma_buf_attachment *attachment;
>       struct dma_buf *dma_buf;
> -     unsigned int domain;
>       const char *placement;
>       unsigned int pin_count;
>       u64 size;
> --
> 2.34.1

