Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DA4C54E67
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 03:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955B910E846;
	Mon, 18 Mar 2024 03:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U9ILmR7x";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C1C10E846
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 03:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9AFcZQuEY2ndcbxUXpj93e3OlCxbby2jtLoyQf6oXQMBqlnYIVaQTCThhNzbTgz8KN+z2D01ON5pD253CIrJt8yOscR7G/pkWZlfEYYzWbrllMLkrhsfhD7kvwJpHbdglM9cdib4hIbJvG7kkibYP4xmm0szgYSJ75ZwIduflXGA6xyq15TLcMptcYEJWthMFYSTmgHqMdQRHe+q5zRe0HpplKep6thnYyur4LSg0Z0AgLXCOsIyadonDapjSBNT3qFSyDpcvpn2A2cfAHfw2wzP3dlJd6mOPRKp6xImHD49b++sN0Fnv5sEHd8WMjBIyXA7ynI1YxYADH24/dwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbAnopCwMcOB/9LJop+bLnVEw/WbaK8w9GSckv0vUHA=;
 b=hqEqGPkgTRxCi0L4WtEilynFJbLw2GAo3DEVR82KI4jiW1LHUli5cz1sx6IUzi8geS3mtxUorU0P4BWE9nY7yh+8w2oMcqOk+mfNW0tinXuLIUqIy0k3rs88YLtsQNs6timtOtjqqLb8EudCJXJ50hsQ3t4ZdDfl1UvLv2spuIilVz7G7z+Er8CUyiPYw3YxNrHK4Ao0Kp1ysHzVH8la3RS/qIXbjGphWO3HFXH+BTYmqXojmOo6oNR3YAMdR9YMQCbGm36LNyqBg4ePxcLA1cNUMYx8pndn+WdZyAqJcOmoofB1eWSa5gpcgPqK9E+oBCuZZ5leSqlSuVpREzg9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbAnopCwMcOB/9LJop+bLnVEw/WbaK8w9GSckv0vUHA=;
 b=U9ILmR7xXlCuf9C2PSkNRh18rY3yozspdCyiJx1XLi3v9JPmm4SDoP8ZW8xozvTdS0JfpZcTh5TFS5AcERC7y2dyzu4UCmjxOyZngM5HnKrAbMlBH3ffzH+tfSQUY+JS8CdgaNd+eo0dxwDKmZjQ7BlECtLlWDosDQ93PxqAzQ8=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 03:10:45 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 03:10:44 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS
 poison
Thread-Topic: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS
 poison
Thread-Index: AQHadSaJBr4gdfmoSECGZaqsZ8CaBrE7vD0AgAEbMgA=
Date: Mon, 18 Mar 2024 03:10:44 +0000
Message-ID: <PH7PR12MB879614DB1AEEB2B6491D64ACB02D2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240313091155.347161-1-tao.zhou1@amd.com>
 <20240313091155.347161-3-tao.zhou1@amd.com>
 <BN9PR12MB5257021E902FF9AA80E66667FC2E2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257021E902FF9AA80E66667FC2E2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9d723123-62f6-4aca-88e6-d355f27537b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-17T10:05:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB7014:EE_
x-ms-office365-filtering-correlation-id: abe32214-1e81-4dbf-a966-08dc46f90065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mM6uFXp3hlFfberDrQB3Zp3/13UTnkcRrYcDD1yjJ45OOGPVXAG5Y+BEpZtFqIDAziAsdTTm42kejvCo4AHg0lSKtA1RQzvDm8sGMcpgrH0xcvKO8NFtNRJwfaIpRoEAaaO/pWRTFOdYe+Wy4Av1h9hPa2uOYjxBw0Yv3Z8JS+vM3WGG8Td1KpugaPmE0WEl8CvO2mmunfdzGS20TbfawxQ1yLNsaw46kDAmyWJOL3z4550ItVWQhY7o/Uq3Yy4Vft6KPbsYTGuDf02HRtURsHNrNtrjeHypygzsr5y4G57eXgE/kqg4TqRorBwbFWY+5ZzdfZW/C/iKovUBxQppQ6Q0iVoE6AaiJnnEy9Im2BfXK0q2lIXkbHkM0FS9BQ01jt2Io7A1HsQKYmaMTxEatTGdO4wVzf1u9UGvy0fxph/KWjhTqVRmtQAbe/WhlEK45/PCueZsYjC2Uh+aeZUQ4b0x5G2tNovIkLgdiD28CCXWd5+ZIkP5RKF9cDWN7bsuCQkmBdaZ8FWu4I5mQrsgtJ3bqH581cCf3jIpTdk0hea9yGrSu/LI+4hVPHoXBS4awLnZBED2/9K7XwO+b37s3ipz2E9KxlyImU5NfXArGnbzVQe7k/YkSkOxkFcbv9vLMsUWF4kjdmoT02pRtWyeaEogp2x4UM3jlIyVIsJMHqwRuPWtiDsLY2UWc6L4OoLDQHpjYWYfGQJtEpSwMhevVLz/CgTzXfJctEB9lWY0Qs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EVx6iD5oqR1wb7liCNmyNnY+lSrmpc5iDi3DJrwyIVQC+BL3+3/GtV/GGiu9?=
 =?us-ascii?Q?uuk4V54lRFmka7JU4irDKV8EuR6ZbhRZpE4Tya98o0GDkZJodvi7pB5Qu+86?=
 =?us-ascii?Q?oA5aMPERzLnXePYgrvwDnAicMlDqTe/rLEHfxzBkqPEwiRnAkm3guIm0QgqE?=
 =?us-ascii?Q?hc+/KducWyV3NHoEksWflYsnU41nL3+HMVlVk3FsxpIUP2jAH9txpFzSievh?=
 =?us-ascii?Q?KfGYAAk30gY9daecdYM6emNmp9edqaEEV0syzZkylYlD0mEi9xq4P8DQRfBR?=
 =?us-ascii?Q?3chi/hw8+nQFv6ZSrZn4Jqz/nF6Em84krvgXLuBXstpM1qAWZY2zK9HdZrjY?=
 =?us-ascii?Q?0YtfyVp198xjudrULpNbxIADKxm2hUTejz9ePdGTBTxuNJgVua2LqvwlR/N5?=
 =?us-ascii?Q?+sW/cXf0kFVcBEUsDDaT99mCiFB/bacTOI7hxqcjXyHv/cLakDBCckSsvvao?=
 =?us-ascii?Q?Gd0FtwHNymfsEzOLIsWkzOg3qc8a2gXA4J8rkRpMQaMzDI8C89gxGUZqY0l5?=
 =?us-ascii?Q?7H4stiCkwDlMRi1MWA2EyHZIdm9Qvsi70YjVa45RMtfSEVUJLZOPlkPo4nYc?=
 =?us-ascii?Q?qjfzySa6yQhKsLigRNwdT7eyPHuCWUTecr1Udk9VFC5DVcpE74kxkF36ZTBT?=
 =?us-ascii?Q?52WHF4NjSKyUos7SWan8pWHsP2zZWd7MMrAdW4ogoJl2o5pVR6gKRJ8mecnv?=
 =?us-ascii?Q?6+/RVHEepnf4uBWQH9avou0gRwN0WW1W1gf+uxYn6nmEUiu5EdXyP5gZfFge?=
 =?us-ascii?Q?BEhWdMEXMkQogMLID/i97IUF3yDQOYnRtPSy/u7DZgnY2FDbt/BWYB3OmmQg?=
 =?us-ascii?Q?Z6VXlLHisE6EqPXNQAjcD5vL6Mv6qe9Ht6gMXnzIYCBm0Ecr7quGDEFIOVaG?=
 =?us-ascii?Q?4kWPqllBtsDeh9LRpcE17Gx9o7+X/JBLkNbtHhhjtU53n8uUXDWB8QD06HsN?=
 =?us-ascii?Q?esbTt7e4wmOl89p8n8MNmzi5HNO0XOr2x2XmtvfIWp6Z9QFer4d17FWyBPCd?=
 =?us-ascii?Q?JMI8BfEuexUfGMrgXjnlX2AkUEMdX1kxA5oCi6p51y38sIWdWAnz+GQaO56T?=
 =?us-ascii?Q?pjT2k45ekOkD/0OLWbva+MBW7nfC0ZAEIqxAEFJwGZtesLoNRUydvbvzNlJG?=
 =?us-ascii?Q?N0Vc/BHWe8SwItSEmWSLignWgXY1G0mVN8ik29nxJ/Qulg8/5GfAKYxF4nqc?=
 =?us-ascii?Q?araljJtaqCuhoO5Ogn2/5BxR6gcbL4m3/QAr1pQ94RAN9K1mzJdzZN8U/ELx?=
 =?us-ascii?Q?zmdWJiQtHXL4eEJ2+PNHss1Cu6KzdHULS0V2njDGAIK1ZZmUqp2S+XqcI3N6?=
 =?us-ascii?Q?nqL/mZW++w0Pv1+AUkqcaNnT8vrRzVD0IxLE1wif++UB/cZeAWI1Xln/VKGb?=
 =?us-ascii?Q?zYRQhKqwwRniR4CvqAuetru76XJ4nO9iigCRSNKx/I57aEzgAhceWxgFn17z?=
 =?us-ascii?Q?3NgcJBm0jLSTSPr3wpwdP7gZEcMCSc+UTk0ZAPCDsGrXbG4gKLCbbonjLiD7?=
 =?us-ascii?Q?w2MzoGQ7YYBwmZTkNtrzZg/STyhUg2dspyY4jbeNiAQ0cpf0bznq3wT43F0s?=
 =?us-ascii?Q?LfrQ06Rl6ZLcBUgsb7o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe32214-1e81-4dbf-a966-08dc46f90065
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 03:10:44.6850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2Hq0sWH2gGDOrTXhe5qFYuKIzX/VB5uX8sMQ4u1mSUla1BpeKjhZP388HkTBFQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014
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

[AMD Official Use Only - General]

I can remove the support for SOC15_IH_CLIENTID_VMC from v10, but the reset =
type should be changed from bool to uint32 for all versions.

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Sunday, March 17, 2024 6:10 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 3/3] drm/amdgpu: make reset method configurable for R=
AS
> poison
>
> [AMD Official Use Only - General]
>
> Let's not copy kfd interrupt handler and the work queue implementation fr=
om v9
> to v10 since the firmware/hardware design are totally different.
>
> We shall have another patch to fix kfd int v10 for poison consumption han=
dling
> and also v11.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zh=
ou
> Sent: Wednesday, March 13, 2024 17:12
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS
> poison
>
> Each RAS block has different requirement for gpu reset in poison consumpt=
ion
> handling.
> Add support for mmhub RAS poison consumption handling.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 14 ++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  4 ++--
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 20 ++++++++++++++-----
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 20 ++++++++++++++-----
>  7 files changed, 42 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 9687650b0fe3..262d20167039 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -760,7 +760,7 @@ bool amdgpu_amdkfd_is_fed(struct amdgpu_device
> *adev)  }
>
>  void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device
> *adev,
> -       enum amdgpu_ras_block block, bool reset)
> +       enum amdgpu_ras_block block, uint32_t reset)
>  {
>         amdgpu_umc_poison_handler(adev, block, reset);  } diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 03bf20e0e3da..ad50c7bbc326 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -400,7 +400,7 @@ void amdgpu_amdkfd_debug_mem_fence(struct
> amdgpu_device *adev);  int amdgpu_amdkfd_get_tile_config(struct
> amdgpu_device *adev,
>                                 struct tile_config *config);  void
> amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device
> *adev,
> -                       enum amdgpu_ras_block block, bool reset);
> +                       enum amdgpu_ras_block block, uint32_t reset);
>  bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);  bool
> amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct
> kgd_mem *mem);  void amdgpu_amdkfd_block_mmu_notifications(void *p); diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e32a186c2de1..58fe7bebdf1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2045,7 +2045,7 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>                 }
>         }
>
> -       amdgpu_umc_poison_handler(adev, obj->head.block, false);
> +       amdgpu_umc_poison_handler(adev, obj->head.block, 0);
>
>         if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consump=
tion)
>                 poison_stat =3D block_obj->hw_ops->handle_poison_consumpt=
ion(adev);
> @@ -2698,7 +2698,7 @@ static int amdgpu_ras_page_retirement_thread(void
> *param)
>                 atomic_dec(&con->page_retirement_req_cnt);
>
>                 amdgpu_umc_bad_page_polling_timeout(adev,
> -                               false, MAX_UMC_POISON_POLLING_TIME_ASYNC)=
;
> +                               0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 20436f81856a..2c02585dcbff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -186,9 +186,7 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>         amdgpu_umc_handle_bad_pages(adev, ras_error_status);
>
>         if (err_data->ue_count && reset) {
> -               /* use mode-2 reset for poison consumption */
> -               if (!entry)
> -                       con->gpu_reset_flags |=3D
> AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +               con->gpu_reset_flags |=3D reset;
>                 amdgpu_ras_reset_gpu(adev);
>         }
>
> @@ -196,7 +194,7 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,  }
>
>  int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
> -                       bool reset, uint32_t timeout_ms)
> +                       uint32_t reset, uint32_t timeout_ms)
>  {
>         struct ras_err_data err_data;
>         struct ras_common_if head =3D {
> @@ -238,8 +236,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct
> amdgpu_device *adev,
>         if (reset) {
>                 struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>
> -               /* use mode-2 reset for poison consumption */
> -               con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESE=
T;
> +               con->gpu_reset_flags |=3D reset;
>                 amdgpu_ras_reset_gpu(adev);
>         }
>
> @@ -247,7 +244,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct
> amdgpu_device *adev,  }
>
>  int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
> -                       enum amdgpu_ras_block block, bool reset)
> +                       enum amdgpu_ras_block block, uint32_t reset)
>  {
>         int ret =3D AMDGPU_RAS_SUCCESS;
>
> @@ -311,7 +308,8 @@ int amdgpu_umc_process_ras_data_cb(struct
> amdgpu_device *adev,
>                 void *ras_error_status,
>                 struct amdgpu_iv_entry *entry)  {
> -       return amdgpu_umc_do_page_retirement(adev, ras_error_status, entr=
y,
> true);
> +       return amdgpu_umc_do_page_retirement(adev, ras_error_status, entr=
y,
> +                               AMDGPU_RAS_GPU_RESET_MODE1_RESET);
>  }
>
>  int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev) diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 26d2ae498daf..4365a20eeb49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -103,7 +103,7 @@ struct amdgpu_umc {
>  int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);  int
> amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if
> *ras_block);  int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
> -                       enum amdgpu_ras_block block, bool reset);
> +                       enum amdgpu_ras_block block, uint32_t reset);
>  int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
>                 struct amdgpu_irq_src *source,
>                 struct amdgpu_iv_entry *entry); @@ -123,5 +123,5 @@ int
> amdgpu_umc_loop_channels(struct amdgpu_device *adev,
>                         umc_func func, void *data);
>
>  int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
> -                       bool reset, uint32_t timeout_ms);
> +                       uint32_t reset, uint32_t timeout_ms);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> index 650da18b0d87..94ab1f33fc4a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -134,6 +134,7 @@ static void event_interrupt_poison_consumption(struct
> kfd_node *dev,  {
>         enum amdgpu_ras_block block =3D 0;
>         int old_poison, ret =3D -EINVAL;
> +       uint32_t reset =3D 0;
>         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
>
>         if (!p)
> @@ -153,6 +154,15 @@ static void event_interrupt_poison_consumption(struc=
t
> kfd_node *dev,
>         case SOC15_IH_CLIENTID_UTCL2:
>                 ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>                 block =3D AMDGPU_RAS_BLOCK__GFX;
> +               if (ret)
> +                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +               break;
> +       case SOC15_IH_CLIENTID_VMC:
> +       case SOC15_IH_CLIENTID_VMC1:
> +               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
> +               block =3D AMDGPU_RAS_BLOCK__MMHUB;
> +               if (ret)
> +                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>                 break;
>         case SOC15_IH_CLIENTID_SDMA0:
>         case SOC15_IH_CLIENTID_SDMA1:
> @@ -160,6 +170,7 @@ static void event_interrupt_poison_consumption(struct
> kfd_node *dev,
>         case SOC15_IH_CLIENTID_SDMA3:
>         case SOC15_IH_CLIENTID_SDMA4:
>                 block =3D AMDGPU_RAS_BLOCK__SDMA;
> +               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>                 break;
>         default:
>                 break;
> @@ -170,17 +181,16 @@ static void event_interrupt_poison_consumption(stru=
ct
> kfd_node *dev,
>         /* resetting queue passes, do page retirement without gpu reset
>          * resetting queue fails, fallback to gpu reset solution
>          */
> -       if (!ret) {
> +       if (!ret)
>                 dev_warn(dev->adev->dev,
>                         "RAS poison consumption, unmap queue flow succeed=
ed: client
> id %d\n",
>                         client_id);
> -               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, b=
lock,
> false);
> -       } else {
> +       else
>                 dev_warn(dev->adev->dev,
>                         "RAS poison consumption, fall back to gpu reset f=
low: client
> id %d\n",
>                         client_id);
> -               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, b=
lock,
> true);
> -       }
> +
> +       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block,
> + reset);
>  }
>
>  static bool event_interrupt_isr_v10(struct kfd_node *dev, diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 11641f4645e6..2a37ab7a7150 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -145,6 +145,7 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,  {
>         enum amdgpu_ras_block block =3D 0;
>         int old_poison, ret =3D -EINVAL;
> +       uint32_t reset =3D 0;
>         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
>
>         if (!p)
> @@ -164,6 +165,15 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>         case SOC15_IH_CLIENTID_UTCL2:
>                 ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>                 block =3D AMDGPU_RAS_BLOCK__GFX;
> +               if (ret)
> +                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +               break;
> +       case SOC15_IH_CLIENTID_VMC:
> +       case SOC15_IH_CLIENTID_VMC1:
> +               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
> +               block =3D AMDGPU_RAS_BLOCK__MMHUB;
> +               if (ret)
> +                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>                 break;
>         case SOC15_IH_CLIENTID_SDMA0:
>         case SOC15_IH_CLIENTID_SDMA1:
> @@ -171,6 +181,7 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>         case SOC15_IH_CLIENTID_SDMA3:
>         case SOC15_IH_CLIENTID_SDMA4:
>                 block =3D AMDGPU_RAS_BLOCK__SDMA;
> +               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>                 break;
>         default:
>                 break;
> @@ -181,17 +192,16 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>         /* resetting queue passes, do page retirement without gpu reset
>          * resetting queue fails, fallback to gpu reset solution
>          */
> -       if (!ret) {
> +       if (!ret)
>                 dev_warn(dev->adev->dev,
>                         "RAS poison consumption, unmap queue flow succeed=
ed: client
> id %d\n",
>                         client_id);
> -               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, b=
lock,
> false);
> -       } else {
> +       else
>                 dev_warn(dev->adev->dev,
>                         "RAS poison consumption, fall back to gpu reset f=
low: client
> id %d\n",
>                         client_id);
> -               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, b=
lock,
> true);
> -       }
> +
> +       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block,
> + reset);
>  }
>
>  static bool context_id_expected(struct kfd_dev *dev)
> --
> 2.34.1
>

