Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF88C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E1661D7A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E1661D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5CF89E33;
	Tue, 29 Jun 2021 10:38:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD04889DD5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 10:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZVrQTvhqwhDftLibPhD0Yj3biiVnu6M8I+M6Ejc+k31DJ/y5gh8dXtFgrnd1XCTBjbcPKFYCIKpVsIOPk4GB4sTtrdsSiDmYm0pr3bedzDoVKK5+9YioRl7c4qpWrOIZysmmMOFmf8z70UHL2bmCc4hLf/IMEC+CUragG3ZjzIXlqpvVm+Ce2TpE3a9Xnh04CnNtMDBy+fAXSAToltEXucCcMj0ymK+hGkYJP6awoXgYj/MkCgKfzqSQySiiv3Im3ucEaN1NBhE51/EQ9LFeiaqKR5BWTJnVXk4orJotPvhcTNtxquDgkTRFztNZ3O5oDYYR2uZZcMrvck3CYAi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m3n+yegJdn+3/82i17I+09PC8jva1pME/YguLR3oe0=;
 b=j/APK9ytQzhsuHPEhVJoMMqE+QL/5MPW7nfcI28LHEKaD2zI9N0QmhDD2rsbVSXYH9+Bu2KqVchKDI/cgKfDOHXx6ZFRAVOLgMHiWpR8xAMcsrveNtN3jrw8J73B7IXbh9meU7EK9D8DzYaPdxBUxQqpgDHFpbRKbheDCNFQoCZOtLVArpkzTe4K/ds2qRLCRH4PHon++hYWGDf4RwmHdTUE8iH+UNmZdVE/3VPBxGTOgx01X1aSzsxA0p5SJQQ3XGrEMnZXD3kW3rMpx1EAbFXyDDHtxCh06DjqxdcqVbB3mP4/xJHqyQY71fB75RmtbvrRSZrLuOrLlN8/3bOrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m3n+yegJdn+3/82i17I+09PC8jva1pME/YguLR3oe0=;
 b=UGgak8gl3T/qII9Mf5bYtdxFhOSVjvJ8oaoihkGWB1lkzrsxqUYhmefQe0aLRDueLV0SfQFbNHJmacFeNkZD0R2BIuMmyoCE+YkBON06SU3+9IPPJDx8sZ6Xh6qpERpvNYzhyJ/U6vSpAVnPRMY+oIKXcswTBfAjX3yHDSp+K4g=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.24; Tue, 29 Jun 2021 10:38:16 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::89db:544a:c071:d9e6]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::89db:544a:c071:d9e6%8]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 10:38:16 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: Restore msix after FLR
Thread-Topic: [PATCH v3] drm/amdgpu: Restore msix after FLR
Thread-Index: AQHXaY2Sx4Ttbpj/qUGxSli20g4VdKsq0o2w
Date: Tue, 29 Jun 2021 10:38:16 +0000
Message-ID: <DM8PR12MB5478072A28A6371D3B9A56BCF8029@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210625064422.30590-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210625064422.30590-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-29T10:38:12Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=783460aa-556f-44d8-bdab-90ec2ae2bd2e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e353405e-da2a-4a26-6fdc-08d93aea0118
x-ms-traffictypediagnostic: DM4PR12MB5053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB50534C15AC5C3C867E2C3000F8029@DM4PR12MB5053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ooMD2Q9N/iOaRf2J7M50A+JtUQd2s2MAeMCqa2qykFELomJPC8XmRx1CQWwgkbLWQIBNzA6mGioyoqwYtudrDmV9UND4p28RSSJLFeEHQWEQuFe3cLkjBV/PcuLUaGiBD89c8hI8LBtBCimTeKgtnRY3JuZO7o6B5dbgvY9saSGD4g7l0vAZDQiF+z1ch2MIdXd87bqJcOZRM3oRm54ZzpSiEMMKF+gmAfF9TbpqyTsFo2/DVSFHWlgvh6et7NMonRMje2MwppZ0e9seft1SMg9cySlxbNSkCK+MOYl3EXocuv4I9ts0e8OuQkLut4hQ11NjkThZPPrp//XxPqYtBgJ1n3KFg3diAv5o43iLzPQFSzIUW7XZxFK7XZWgLG49LmzxiNkSE8Yjdmm6poScPV/Bhlwvsd1Lvcg7F5xE80SZMrC1dyFxFc9Qur8BCXUX4ef5PY6hke3vgMQvfD9B5EZFccxjXdhm730jRKcAU62WYtM68GqujJxlI9Ew3Q2YRYrRSMdxL7/nTTYM2bznoK9RoQYlN4GR1BijbO5B/cp/L202NxI603c8gj+tW1pxA2/kczfLzZhfvXQfOZntvxvPwyYF81sDtBUZ36uCs2TF1QKhdS2YHcUhcoV6ZvgEqM1xMA9y7cfP1Hq/9bN5cw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(71200400001)(7696005)(4326008)(86362001)(186003)(478600001)(52536014)(122000001)(6506007)(53546011)(5660300002)(38100700002)(66556008)(8676002)(66476007)(66446008)(66946007)(64756008)(26005)(110136005)(33656002)(83380400001)(316002)(2906002)(9686003)(76116006)(55016002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HJzRD4ILWDffIwWBwR1ynsp0XxiPdMAuYNers2WoHu+HigMECMDbcmcgmnC0?=
 =?us-ascii?Q?Qkf+QG9+A9JAavpnZoxEgqBcNJbRkqHJyJR4KGx0hd56+1gU8DLyzz+/PEqr?=
 =?us-ascii?Q?MdTvCVUfmEmm1q0E+NCS7OX/nTf1Ie2IkqZra6M0yso8fwdmDUPTmwDCP/ca?=
 =?us-ascii?Q?OD0l5CMqX/J1WjWhaXIU9UGAEIxDkQDgYoYt2a+2dUmlhqhqGcqKEGODrTe7?=
 =?us-ascii?Q?NNqo4x+IzA2Z6Wq4IORxNmZ0FthWF2SflyhZja4HHss8XGnzsmFRV+zXGM8i?=
 =?us-ascii?Q?5VOfyaZoDLkmEft9rSSx7nxe28bXy9DPtsPUyhQ4L7lFCuMalCOkZ571Uo55?=
 =?us-ascii?Q?K4MROfCjA7p9vHo2fmbJBve5gwTCn4ATOsG0y2j1dD8HyAkKJaV3YF9DtSkp?=
 =?us-ascii?Q?y3D7b8JWcsWPCwzmhFAIyLUo95Av1QPtVl3whCZ7Uth0ukaG9PMKJQqSuF93?=
 =?us-ascii?Q?F2ZY2p2/zmSER3+bOWfByVpAgvfv4qe4Y3t7KQLzXfX3KLoTNkQS1eGBH6bG?=
 =?us-ascii?Q?YaSEUYppAlPgbu6ToLGessE7xvtNqkWSM528sqpiBdbtXMv1CKmav4tUn3W9?=
 =?us-ascii?Q?rfDaZNeW6NxcRULyTjo35jm+hmoBQgTCzvy4HlbtFWsHBjwiyR7ttCL7Ag5d?=
 =?us-ascii?Q?545xhVjRjGOSiMuk/bdz6sV4wZOiGzRi2HhSipTeJ/mKD/f0J7WeP1RUpvUF?=
 =?us-ascii?Q?eOWPfSRf5WOy+O6+drlVeiAFw8mn7RPpKPuIELObJTTASeU/jz777UhNFwGK?=
 =?us-ascii?Q?Jt8Hp8HpA5aiMawzWWY4EZWEasuD7idhuuXThrcerQv0tAU4I0SDptsk2Msq?=
 =?us-ascii?Q?56bsi6hjzEdGScJ6S4czwFaX5doHwoLvnUOpk781ajnvkbDzCc5ad7ZlnpPG?=
 =?us-ascii?Q?iJNb6PZQQ9PR9l/oze2PppU2kSkDJlfpAJi0FOdrbGSVvKbgjr6/vLDwU4WF?=
 =?us-ascii?Q?bPv2WHcEq27oR1B/8VPlkK56qlR0dh5O+oi0FiKAqcUn3CrW89cWjd2Um1pq?=
 =?us-ascii?Q?yjaNstw7epr/fENPKRJKeQJbh93rTK2b7jyBOovZYeAORv2w9YaoTyK/txL+?=
 =?us-ascii?Q?S14urIFh9MEyxOTGVVUmV8baxjIO/EUoYWSya1uh5x7HS0ThILRyH64AHjCl?=
 =?us-ascii?Q?Qmv5zSpq6eNdegEA0AjhMdcgLm9Fe7tDEi2bc/NETB0y5cqlB/P+LhhmRNWr?=
 =?us-ascii?Q?FDBzL5SMpwjB77q11+2ssCLZChgx7z9UpwEoc6cgd+ex1s4+QPD1NnbweOAz?=
 =?us-ascii?Q?fY/xfLfG2A6JmPkso/fWOQOif/6GVamyszZC0LUTQRGId4CBa0mup1m1NyGo?=
 =?us-ascii?Q?d8TF1Y18jwBMX9x41C1WBG6R?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e353405e-da2a-4a26-6fdc-08d93aea0118
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 10:38:16.3617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pD28VEsms36F1YAuryHqNdhzBJKgiLucC++X2VnxFb2uxiqviWl0+fIrD8ZCSYLIbCRxxNXBpu6uhSxUDVQJmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Ping


---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> Sent: Friday, June 25, 2021 2:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Zhou, Peng Ju
> <PengJu.Zhou@amd.com>
> Subject: [PATCH v3] drm/amdgpu: Restore msix after FLR
> 
> From: "Emily.Deng" <Emily.Deng@amd.com>
> 
> After FLR, the msix will be cleared, so need to re-enable it.
> 
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 90f50561b43a..26e63cb5d8d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -277,6 +277,16 @@ static bool amdgpu_msi_ok(struct amdgpu_device
> *adev)
>  	return true;
>  }
> 
> +void amdgpu_restore_msix(struct amdgpu_device *adev) {
> +	u16 ctrl;
> +
> +	pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
> PCI_MSIX_FLAGS, &ctrl);
> +	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> PCI_MSIX_FLAGS, ctrl);
> +	ctrl |= PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
> +PCI_MSIX_FLAGS, ctrl); }
>  /**
>   * amdgpu_irq_init - initialize interrupt handling
>   *
> @@ -558,6 +568,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
> amdgpu_device *adev)  {
>  	int i, j, k;
> 
> +	amdgpu_restore_msix(adev);
>  	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>  		if (!adev->irq.client[i].sources)
>  			continue;
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
