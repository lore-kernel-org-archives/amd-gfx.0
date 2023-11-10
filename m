Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A95C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 19:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C40010E1BB;
	Fri, 10 Nov 2023 19:08:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4139C10E1BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 19:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIrgEt1Ytib4AwxA3lHAOFeEReqmuA6h1Xcubo0dpYvcH9RIK5vt9Jt1/yHW8vXt/hzAJKQJ+kDnkVCi5W88VbPhnx/0lv88aRb+8zTOxabWidWRAV94AGGFhymFcJArYfctWg9XQ+WoT37ZFIXb1xdl3I97ZP0CQ9EX4FoF8bLGCbTkybatH6o1aWC5npPR/H56vrqNNSFsJKsNBOj2wNavU15gVUt+5QVlhCbXy6qeYphaDYE5IxpOEkqbmjT0QJZITRggOdcn0UMcqhLs4F+wNchZgNTRXAq4+/XD6l0TYp5a+aVXkdUJ6fxRPIB5bHBB2hm7m3b9iyHqppC0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZbLyHjE1cEWYE10SP5KuPMIBzEHxaf/pWulqn6PHFE=;
 b=jW9zeBafHxbdN5fNmtYnMEGsVvcdIsHdleBv+BaexmJ0mQBpkQoO0pZnRbU499SACHHIH91+0H4h/BuVEbZwHwVP7P4JPnssZ9PdkUUrMGl3faqSfSb96mGj537UsPzOgudTQo81Q7LkKeCVR98k+Kx/3KYoKKYRKYGxaUBy23AhR/cWr/zqVBX3OPtcYSQogTTA+UUsPHc/tK0SeaeRfDOaR4FjN4lvhULfF1qKr82iqAjNzbL0IvKE6SFgH+g6aJ+CgqLfq84nyyzDglvJjT7rEITJn9x+1rbmK7xoXfvgr6Duxb6bQ/erAPHqI/Sc5Vo9NtFOpiqwrmWkrY2hGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZbLyHjE1cEWYE10SP5KuPMIBzEHxaf/pWulqn6PHFE=;
 b=qVDOYPeNm+BVNxwe9HkMHH0/9pA/NDjuI8AQ7xKGg+bn/ocOxDfvo7AHkD4Dc4tzOoDwS7QD4eP86HvAkqmOk5/9eLIaH0Le4hq4NGa3xOfkP2so21xAkjVjrB1PykoJGQGwHcASDIcJXNLt/wNkcrOCItbHS0DiMbROuvrOsmg=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 19:08:36 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:08:35 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 16/24] drm/amdkfd: use bit operation set debug trap
Thread-Topic: [PATCH 16/24] drm/amdkfd: use bit operation set debug trap
Thread-Index: AQHaDldaPSMDHX2yE0uaHGj+GaXHQrBzxdTw
Date: Fri, 10 Nov 2023 19:08:35 +0000
Message-ID: <DM6PR12MB5021F17F6D01763004219A4E95AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-17-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-17-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=37d255fc-d511-4f29-9ef8-25efd3647d64;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T16:16:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|CH2PR12MB4311:EE_
x-ms-office365-filtering-correlation-id: af098c97-d332-4cb6-d766-08dbe220704a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+UWqDffgjPRF8WwaUOAAU+5+zP6YTXYHm0DNICvY+krn53veKT/wuUtrKbT60RZo3BWOGjRj758vYIL6zWOGUPP+2XmSt/kabCefIRUIswWtjjWnUfARI4MNDksORRttz/2ppbma+6MDs6hMqx/W2xXRBXb0/MY9FX9m3FVYwcqEXVsdVVXaxVO1OMod2UqGqxx3mQLcPzs+X3ktkfEq2O0YxNZUmxtX9Rb8XcpTCncpGb9zK1XeuYDlRr5v6KA9lvHPiMQIA/u98O+v8kDe/c/ia2j+W/+pVdsl5aRBOOMutBPuHmYdfjoQyv18TZLuh76mTvBbwpMLCT+vo1LkchnoQb/oApv6yITOy7F8CnV7ZP4jhpmHzUL2A8VTMSVwd9ZzQvWZdVUa7GSYJUgLVqllhv75m2bAvxSp1w7HdJXSqxKTx3y/BuUfuWkWh1/vBlZEVorxoT8rIgK5rRSXtqp6ZilFpXFyE7PmoCyW8YTvPPDGVNwWceh/cKNOHx3GqNhqrsxtHVISHlYt5k9SoeNykp/uUhW5Vr44QcbKG0XisfdFlqgsQJy3emyadB49dsS7hyjP1P1svHYsuO7eEsyQe6bMKP6luYOexN/Vc/S4EcLeIcJKnQZ29K3jAAP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(110136005)(8676002)(478600001)(52536014)(4326008)(8936002)(55016003)(83380400001)(6506007)(53546011)(5660300002)(76116006)(66476007)(64756008)(54906003)(26005)(316002)(66446008)(66556008)(71200400001)(41300700001)(66946007)(2906002)(122000001)(86362001)(38100700002)(7696005)(33656002)(38070700009)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xxjwRyzJPQjU6o6BcboMEhAA4rwDMb+3argUhgbLnUpK3uFyOgQrM2URvBkI?=
 =?us-ascii?Q?WUwCbLX7Zoiar/Wbv6wZCid4/EV2o7q7TtykSk98hlvIgS/J+C4CXEPIEIW+?=
 =?us-ascii?Q?5du727MwfccKSGFYO8XS1Jkx6FvIC7mKZ7WDCPwEWIhaMItiCDcy73oxSOQQ?=
 =?us-ascii?Q?xiKzE2e9PUocF1UEHWlWaeXOWg7ixiQIBEQYXdZ/lT74FciKbO2YxiHPx3fD?=
 =?us-ascii?Q?8db6a5cSMIwGo5zpbfE7cGj0yGkLCwgu//hEqyi0gZfzPOqujq0Y/FLHCOEK?=
 =?us-ascii?Q?WNC+bYJwww5wx1pNjphDIwyWX6zgpQM+LvnjHdTHcAz/24iibitso4HovJ57?=
 =?us-ascii?Q?zne+44dx46QOB6/K/I+lt5mUc2CT/J1KbzmVvP0TfdgrY2DYjWz7c/sCaAKE?=
 =?us-ascii?Q?tRbRoKharVvXCfWIA7+aK4oSw5wyPLSndFBQHCdRaJDXuIii9sCl00CTXitQ?=
 =?us-ascii?Q?F+PZFsAGTpGlPlJ1we7nlXT+vf5uOcZEIYk2Rc1gQF8AmbMfESuJDAYBj0dB?=
 =?us-ascii?Q?JpADmy6spyKXU0tuS3r+KoleodWrlHWjA6EdmUQndSz7/ubQfPUjbyrE8jQc?=
 =?us-ascii?Q?i9K88fzsVG+QfgstALzL/eaHnmiSeLV6mfCBkDjqx8FVaiyrGvJwvKjypSeP?=
 =?us-ascii?Q?Myh2EhIRNywZAjUiiDfkDKsroJ02/hg1ZpFMD8nkWbN7h/gxXHAJ9rDLqNJG?=
 =?us-ascii?Q?Am1V6mRpHxna/+EGAw4QCiXM6CMwGHbinmNrnMtP2JXf1IHTSUJ3LaQbiYU3?=
 =?us-ascii?Q?em496D7k+UJZHLOW9e/lpvh4eoL5NUOSUSKAEKdWV473XkCt3ZEUR9xhN0Pt?=
 =?us-ascii?Q?Cli+ZN4es4Yg0iF6y/fQhAiTYoIsRh8nBM+/Qo4eE6w3WV6Yi2tYC451OEqY?=
 =?us-ascii?Q?fpyVKloMudEZt7VBZMcCk15C0JH/CZAHT4KCkyXfts4XbPz1nZuXmVYLlFco?=
 =?us-ascii?Q?xou5/EwoePRq6FZXZaMd7nYyIgRrhsqcJoI7sKqGNy2bvra8XPvY/tiKrxlQ?=
 =?us-ascii?Q?Z8MvBKrJZtldRY6rKHH7a7b5ThwuyvWuvSEa+IBoPw10jbVYU6wE4WZ20x1e?=
 =?us-ascii?Q?C3KmMxIwAA7Rud4g7gIpNNM6JY4HQl5vaBMR34L/LUR4Nfq4cI4c10evdcVP?=
 =?us-ascii?Q?hMiUk13Q++DmIdathg2TI7tJci6s6w2WnNN6CD7obZpoxM0oCnOC0KyiB6oI?=
 =?us-ascii?Q?zq0e6KbaVit/T/8CyomLAKus8Yi057xjzyUCIKaA909BQxJhxjyMyUpPLpRK?=
 =?us-ascii?Q?XWT9DzvUE2WUmF3X2iSiN/0I+HS1JMl+8B3UN1fAgbrqhcrvPHaUu/a8iTIk?=
 =?us-ascii?Q?L4CODC4zpJh25hM7ecjPOdRjgZdPYeWfHrtkNSVIL4TC134ckX7PUU/mlgDW?=
 =?us-ascii?Q?D3YGSMNUcZtpbKM+uvZT0u2GOMwtXs5qF0IGk25a3VBwz4Ymgvf2/9lsKuq2?=
 =?us-ascii?Q?b9qcEVPsBBTmOyHkE+SXaaJcX+wWdAnEntxEME1stRZ+fPLr379OgDOOYOdZ?=
 =?us-ascii?Q?7CAXZTh3Dt3x9Kpvp3OgSZlEso1rBnXTK/IwJnsxnyWoKtcL5uXL7rwH1Yji?=
 =?us-ascii?Q?SCDMoGjXtCXvMJXsSaI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af098c97-d332-4cb6-d766-08dbe220704a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:08:35.3227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTYa/mFLyAYOlFolGo5tMYXNXtvvjXlPgL1RyBQ4nQAnOZQG8YlsYhcIuFh+tpMouw2//dojDetD5xfUIBmIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Friday, November 3, 2023 9:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
> James <James.Zhu@amd.com>
> Subject: [PATCH 16/24] drm/amdkfd: use bit operation set debug trap
>
> 1st level TMA's 2nd byte which used for trap type setting, to use bit ope=
ration to
> change selected bit only.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index fbf053001af9..a0b729c65a7c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1434,13 +1434,23 @@ bool kfd_process_xnack_mode(struct kfd_process
> *p, bool supported)
>       return true;
>  }
>
> +/* bit offset in 1st-level TMA's 2nd byte which used for
> +KFD_TRAP_TYPE_BIT */ enum KFD_TRAP_TYPE_BIT {
Nit pick. New line after comment
> +     KFD_TRAP_TYPE_DEBUG =3D 0,                /* bit 0 for debug trap *=
/
> +     KFD_TRAP_TYPE_HOST,
> +     KFD_TRAP_TYPE_STOCHASTIC,
> +};
> +
>  void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>                                    bool enabled)
>  {
>       if (qpd->cwsr_kaddr) {
> -             uint64_t *tma =3D
> -                     (uint64_t *)(qpd->cwsr_kaddr +
> KFD_CWSR_TMA_OFFSET);
> -             tma[2] =3D enabled;
> +             volatile unsigned long *tma =3D
> +                     (volatile unsigned long *)(qpd->cwsr_kaddr +
> KFD_CWSR_TMA_OFFSET);
> +             if (enabled)
> +                     set_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
> +             else
> +                     clear_bit(KFD_TRAP_TYPE_DEBUG, &tma[2]);
>       }
>  }
>
> --
> 2.25.1

