Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C2DD0D7B8
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 15:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D8F10EB0B;
	Fri, 11 Oct 2024 15:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jEQvHjhl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669F510EB0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 15:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM926w/jHRqc7X7ujgT71ksMa5Bp15hkGvV5/lhp5sUdUsuolXn73axXvD1WOMl4J+EPJmGOMdiwoJ2BtvtaD9PIfdDk4jg2Ugk0NuLK7ZiRjm4FywRu8tR5GIFcj1yqjJpmFODToOSi2vKap9kjIDISDTKcToXxmNT9KWBteVbRfvDCYj3MI83LeYXtSCtDLWa8HN/yTbqFs6LQUg0PB1GwvCCdbedNDrhf2Nyn9dsvMLfUNYLfqdtydLQSkz3bxdW28SH3Mcx3Sihp/6ns9NQeQooPfcRfLch48nWGSwbzXfmjnf9wUUPS1n/5otuH49Jjfx3qpAHa7OU+Bw7h/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQmbZnT4+m3EeGvQXM6R4L+unHTdkqbbMEE69tkmpeQ=;
 b=NSlYNDNVl+jF2EZbTidvJp9i8hNwXg3u2G3UAE1ep25NOzulvz4DFmEVs87TV8yFj/n6ydy9/LUtB/lU5pgNs/cJJ2nieYO8sa7m7UOWyz842n2yjccJzQyYAZ98KahalnhZqrkh1hMC/gDk8AJuev31lSZIxOQVtLvI49Payqj8hMayNq80LmaTA0xtRXUTmD/kkNuEXHnfzMK0Uja7o7Q/GSNLklHH4IfvtXaqRY7q0mKYyv8aAduUVP2vMCxxj9s9+oIG1Sx+STRzHouKNc+DLsWUDWh91w/zmaxg46kZVio1Ibm5XwZHTWoWo1rDwiY1lCkNgkV5vZUFnkZEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQmbZnT4+m3EeGvQXM6R4L+unHTdkqbbMEE69tkmpeQ=;
 b=jEQvHjhlESqFuI3gp0q+zG4hXh77WcMfucgqIllu/2t5eW01mEaqciFglwby7zgAvL9KhrEFCeQZsa19SfHZcv63GNz9PvXJxG2Cv9dHDsfqEdc3LHM8v0HUc0ehDxYDl0aRE2h/5nrhJm/bXItCzMMWAk9NDRORdRuR3d/B6AY=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:07:23 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 15:07:23 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Li, Yunxiang
 (Teddy)" <Yunxiang.Li@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
Thread-Topic: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
Thread-Index: AQHbGy/40YzDgh5dyESdZoLWW6e6NrKBpVyQ
Date: Fri, 11 Oct 2024 15:07:23 +0000
Message-ID: <BL3PR12MB642501535A7BEEBBBB32C54DEE792@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-2-Yunxiang.Li@amd.com>
In-Reply-To: <20241010161730.13416-2-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d75fa812-a730-4f30-a48f-cbc6e4fb1d88;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-11T14:57:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|PH7PR12MB6659:EE_
x-ms-office365-filtering-correlation-id: c67d59b8-c612-415f-a93a-08dcea0668ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HULNiY/GO06qe4MKweNfmVQK+MRADSo+0M9O//ERHl6bXaQ2pXVVEdmV5E3n?=
 =?us-ascii?Q?RbUHv+skAkOL32BXiyi4s1DzdbIvdUwRF99YbrgYqZ8LW0RihVN+uJKACGu0?=
 =?us-ascii?Q?F799/aWywoiH2LSfOm6G0vnfwQUEg+0UtC5DPntHfYaLrSUasCWiRUZlwmbk?=
 =?us-ascii?Q?nTmNT39HHfxToDJif0AhI4XHg+gZsKWvxBLWoppLvtglnhbx4dl4hHBkZBX2?=
 =?us-ascii?Q?gpmtA3/o8Z+zc8nEx1fZ04cwi3HYX2K2Vf/809xnsIAgM7YkIAdmCMwV/4Bs?=
 =?us-ascii?Q?dTJFnV5nxdvKdskN1imuEJh5CWsG/Hm6CHx7Yu/oC/P4uhDw7Qq844+9pFMw?=
 =?us-ascii?Q?22XdXXB98DzDvOFKWeyIlct87cjI4DasDM5XhTHr+ZrAIdo3TlztouzIvGqr?=
 =?us-ascii?Q?2TwsLBlAoOUpGffTPaSTkkxEXyo42PpUrkEtkHtcMkdevGZYBAizPWouv0Oe?=
 =?us-ascii?Q?WLBc3gUxLgt3xCxLpIkQWBp/BxGO83nVRvt5LhNtOVcE85N8FBWnPrdMgKOb?=
 =?us-ascii?Q?WkJH4zZrlbTrYn1hUB/nZl6NwPxgEQPjRsF7CXbSlq5VLay3vju2OubuUiOr?=
 =?us-ascii?Q?Dlqg8B/K/SA4KbKDv1/4/0mViCgExzSYi1ZtVYCZyeMaTPNhz56LEqM4dIa7?=
 =?us-ascii?Q?7q6Gs8Dm+N/JhM3RMBalzLQO0NVavFJ6sW7TNuUFnaC7cpG/Tqjrv8JZkrsM?=
 =?us-ascii?Q?H/N88yusCtyVBUGIIPQeovYFdiLgonj8Xtfq+DzuVLbseaVDcqB5oSyxUhTE?=
 =?us-ascii?Q?q5+2xgUor2VT9N+D/m70j8tPlgbF0Xe7j+hnD4kyT3KT9VPIkN7mooMfpEMw?=
 =?us-ascii?Q?8BLKsjeouGYBDv0gBV/CrQf278sTv6m0HXd1ofssM+r1BbT7Jw/sR5llO/Qj?=
 =?us-ascii?Q?aa57r3/W8aWJdLNWEDiqwsGTygbT1CyncrYCpZ56GrEh9c+0pqlQOJVgK3LZ?=
 =?us-ascii?Q?wOP4eZfJ5LSXAI365zPnNuzQNnaAcnrYDZv0YM15+tDJlHX4/IrREYxgvk46?=
 =?us-ascii?Q?4a3r9qiQjoQZZcLKzY4cPv+o5NcQjchKrHG/86nPb8Hz8UxbYOA3XQAIyRga?=
 =?us-ascii?Q?eV8rpFQVofGswHh5ZTCXBPp4JBCbvBf1TIc2BA5ZXW3O1hQz+J3EYBjfjRbp?=
 =?us-ascii?Q?5G+sDK+Cu1+5Wesb7mukhwcnsFT7AntVaUo4rHcJ08cXmsgaH9Q/dip3FGjs?=
 =?us-ascii?Q?uvcdncYiXgkEg2umOmms3SufDQijcmXzf5O05ij7kSqa0Xwbwhai8KJPbGUK?=
 =?us-ascii?Q?ob79AeoPrb22OjyG2bdp4BADjfTZFAiE7+M1RJbz/20wAUFta9wqXOSeFkgV?=
 =?us-ascii?Q?FWBx28eWGgQISBMMOii2Zwdp9CrhPfl29L9s6y6FO+h8qQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OjCBunqrYikCESIUzCno9wILNR2jUMyFASQHtfvYoiOwMT+9igHyqMUZ7eGC?=
 =?us-ascii?Q?SGK3W/PLq3ftwkyOVHgv/UsdmbD+Kr+swk9OUCprmtInHglUpVgBvoSSeWsn?=
 =?us-ascii?Q?ty82muowj1x7d0sZVsNIGdy5FyE+q/6zfxUJuBZOCpsmtD20Enyfk7FILk1g?=
 =?us-ascii?Q?NkMNO3zKWZinJI9g973diWVnlXDUm18637OnRLLLFTVE4TsI5v81ufiiipx1?=
 =?us-ascii?Q?a193/X983jPz0Hw+KoXElHtx88NG2m1Uh2ns7k4Owo9gzkH09v/xnBURbiHt?=
 =?us-ascii?Q?erowJ2qpTJM1abKEithUOJvaUMPsjwfRwk5G0M460HeHsSJjjsoRdjJjrlTP?=
 =?us-ascii?Q?URneEwrXO4AGNHJf+k2x0LBg52d8+wVaPhECJug/TmLnS2wKgPw0uZvu1AjO?=
 =?us-ascii?Q?M5E64wwcFuIfvLitCHx6TDTDrv+6bzhZqo9BAIeJKFOTO8G+AY+2a6qI+e7U?=
 =?us-ascii?Q?GTB6gdmsOEunqlcPHZWrdFuKp2/keozaSVxdZa2I0iSn6m5kVWFlPzemrHwZ?=
 =?us-ascii?Q?PHnE4urOkF515ymnkFGv67rwbp1ECSKy+qda+w+N5yRfK5VsrIGCb32/pnzZ?=
 =?us-ascii?Q?G/fzS+jBNdfbT4//42QbIWi8w0OczOdl1ArnFTzl7rD0a/AFluZrt1Ei+qQ9?=
 =?us-ascii?Q?HJIdH8vUJ+3JtarZVtBCRPUsGJLiccAzNuRnNzeX6akX4Yf60DTk4ExdnsDx?=
 =?us-ascii?Q?mNSijb8wSfcvvrxQv5Hq+aGhj15ZjAWCH1lxeTAUnKyUZYH2enMzWjLg+mq1?=
 =?us-ascii?Q?RHZNqrDgQVTM/P/jcS64ImBzKDebg/lCDMrKQmhdPaUzpZIYTMPvNpmYqFqz?=
 =?us-ascii?Q?r4TAEdh/EYAY8EqPPc2o6f4Xb1YjrBhexDCsFCvmgjuObBhTWC4FClDaOgiG?=
 =?us-ascii?Q?kb7gCzrX+1avEI2As6A8pUF2XK5va8+vEPiM5KAsU0HFjRkNERcePX/IdSLl?=
 =?us-ascii?Q?iLTTwaB/1Ye0/kjyMimOcJKUyLQ2Ft/4zF+ZutbLinZxg6LmNzbtlO2ucz4J?=
 =?us-ascii?Q?woinOf8GFckz1irbHob1gwlr+Q04Pt+i8R8asHQiVlSE5t3D9W6sm6NlCyTZ?=
 =?us-ascii?Q?jcdnKEnejTKAzV0KBxzjC9fEFvg8GXeoxNVwlbsKXnrcFJm4HczspMIOZM5h?=
 =?us-ascii?Q?Lt3ySkGxIA9CkfxEoKVeNzHReFLgpVoG4QZUGBrEkCErXZeiVMKisOcYGYDh?=
 =?us-ascii?Q?FUKh7L6HPs7wbaq0MEYL3TtWMUoOtln3ek9Tth6O5AYuQoPXAIGIVGJa9cAi?=
 =?us-ascii?Q?DJdhSzCH/1RtwggL5dTB5Su2NMsauYknDW+/7LKJSLMyHkFnqBDxoxQy7Iqt?=
 =?us-ascii?Q?Q84bZD/cCflWP2jGayBGa4vnNvv8c/nRks8e8IGvlbMDzpS9R8SRkheTX5Zc?=
 =?us-ascii?Q?XAomRLaRnv7Ni+Dbr1QLtjwQQuWRrlHOLUyRkei7jbMjL2nlbYJOn85S+RYo?=
 =?us-ascii?Q?vYCiUNfaKv30QfTrgocnkKyEm1K/7tbiowx48ORJLZK2PFm1dvlaWEMA2iU1?=
 =?us-ascii?Q?F3ZvQCjcziZ3m2Gzz+hob3mQRQGQ15w9GThhA6Jb+eXT/NiskFMHq1cR4nw2?=
 =?us-ascii?Q?V4v7wN3MKz0eozL3+KI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67d59b8-c612-415f-a93a-08dcea0668ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 15:07:23.0577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juwFp4+9HOiFirf8Wl/CALog9mTNkfci7yTolAaymlMuQslWJF2qLNhl9I8ojUZVshwD7Tr/RBaai75ahukirA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yunxia=
ng
> Li
> Sent: Thursday, October 10, 2024 12:18 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Li, Yunxiang
> (Teddy) <Yunxiang.Li@amd.com>
> Subject: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
>
> When using MES creating a pdd will require talking to the GPU to setup th=
e relevant
> context. The code here forgot to wake up the GPU in case it was in suspen=
d, this
> causes KVM to EFAULT for passthrough GPU for example.
>
> Also, change the other place where we pause suspend to use the cleaner
> pm_runtime_resume_and_get helper.
>
> Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>
> It is unclear to me if kfd_process_destroy_pdds also have this problem, o=
r is freeing
> gtt mem guaranteed to succeed even with the GPU in suspend.
>
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index c9ce95bc3ec8e..c3d510f1dabfa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1633,12 +1633,19 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_node *dev,
>       atomic64_set(&pdd->evict_duration_counter, 0);
>
>       if (dev->kfd->shared_resources.enable_mes) {
> +             retval =3D pm_runtime_resume_and_get(bdev);
> +             if (retval < 0) {
> +                     pr_err("failed to stop autosuspend\n");
> +                     goto err_free_pdd;
> +             }

I am not 100% sure if it makes sense to resume here and then put it back on=
 suspend queue after the
allocation. And then again call pm_runtime_resume in kfd_bind_process_to_de=
vice().
Maybe you can set pdd->runtime_inuse =3D true here itself and not call the =
pm_runtime_put_autosuspend here.

I will probably let @Kuehling, Felix comment on this.

Regards,
Mukul

>               retval =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
>                                               AMDGPU_MES_PROC_CTX_SIZE,
>                                               &pdd->proc_ctx_bo,
>                                               &pdd->proc_ctx_gpu_addr,
>                                               &pdd->proc_ctx_cpu_ptr,
>                                               false);
> +             pm_runtime_mark_last_busy(bdev);
> +             pm_runtime_put_autosuspend(bdev);
>               if (retval) {
>                       dev_err(bdev,
>                               "failed to allocate process context bo\n");=
 @@ -
> 1768,11 +1775,9 @@ struct kfd_process_device
> *kfd_bind_process_to_device(struct kfd_node *dev,
>        * pdd is destroyed.
>        */
>       if (!pdd->runtime_inuse) {
> -             err =3D pm_runtime_get_sync(bdev);
> -             if (err < 0) {
> -                     pm_runtime_put_autosuspend(adev_to_drm(dev->adev)-
> >dev);
> +             err =3D pm_runtime_resume_and_get(bdev);
> +             if (err < 0)
>                       return ERR_PTR(err);
> -             }
>       }
>
>       /*
> --
> 2.34.1

