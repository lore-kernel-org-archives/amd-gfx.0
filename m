Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAB1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 08:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5FC10E934;
	Tue, 22 Feb 2022 08:39:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810A210E925
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 08:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWiYplPRz96R2YXtMkd3eJ1GAeMwLhoOcQWRrUwegz3zvOx569WeYgdf7piVdXwGVunEOnN3udD8cRLLe3YEwlZ4xlATWZYXjwM8Zl9+HbORxzOzaGuHmCJxOev6Sv7kD64s7WEE7+MoJGIss3YFee2Fc9NyJjYjE9w3bfHKOgdRM3ocnO3H8VysjyiRb6GJ14GJFJlTCHeTJZUUROl1uCJW64e+/gHH1hiYWAR2Png9h1R2nrsMwHqE3oG8iGAP7amz/NzJ5YI33prCQO36jPGkUEwzWi3dZZ5tGC5iKoNE1ntDjlnZ+zQPzqHGO+1ojpNKew4IuLiMGSMvkcSf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMVsl+XphJsYEue57xXrZfVS7Dxra1mgRJlTroW74e4=;
 b=WNtFJhEXHgxHdjbQO3izNzyhwM7sXhcvp48wfFOoExGEuAGnvoqALFgqkTFz0aNy74L+j3OWVzdwG8P61eveYj5cBziMSUlQ8OVmyOav/3Bm9u60kYoQXBAeXeh1TpCLQ6A/o/QmqqbbqzKyHIqNpkuMtHipXmcOHaswrfxR0Oz40liIftpX6wPcKJz898ANlZp8UjohDKB/LFzUiBMXr/M8fzOvpCk7s+scNchPMJv2nt34YtMFLgpW8EKXFL3zN7ZoKlSU7WV4Gm9JdPhdtEj0uZnCS3ombX0BGPQM0RG0ACJNLdVlYRsmeVUCvBWSfCJllaJY1RtDpDO6Y96xjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMVsl+XphJsYEue57xXrZfVS7Dxra1mgRJlTroW74e4=;
 b=i8uj9KxudG+JDzrnA1E6x9QcXSgJJnpfp+pvgIjXEhWHNOV+2BHByj5gN//om70RTQt1WQKKfS+SnXRBT46H9aqVxYaObwXY+5ltnDLVwBM9Mmp9PN7WBG8DQeasV307+exdfQ0qgBRhWMug1VHyaoj8Hr2l0H4hVOQ14Fz0mtQ=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BY5PR12MB3779.namprd12.prod.outlook.com (2603:10b6:a03:1a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 08:39:26 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 08:39:26 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fixed warning reported by kernel test robot
Thread-Topic: [PATCH] drm/amdgpu: Fixed warning reported by kernel test robot
Thread-Index: AQHYJ7rYjdx+SKr83E61JnihMIdPo6yfPX2w
Date: Tue, 22 Feb 2022 08:39:26 +0000
Message-ID: <DM5PR12MB17703BA945F89BB64ED36C6FB03B9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220222070652.3373218-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220222070652.3373218-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-22T08:36:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ae4e47cf-be26-49bb-8d1e-80b673fed61a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-22T08:39:24Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 230da4e1-cf50-45fc-b34c-ff34b93ac7cc
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb6f867f-6817-4864-8397-08d9f5ded5a4
x-ms-traffictypediagnostic: BY5PR12MB3779:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3779E28D2669616951E34D4EB03B9@BY5PR12MB3779.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RiZYFEUak5ZHo6yTJMEMgN7fpTILe5s8NwI1j7rL2P409hMWORiJKskFPzrQHF3EGRcJOz5NmU30YdMtkwOShCe0/Q1xEJ6tEOeXu3XY2/NR8f4Oc7ouZIghdVaUQVbq8YLkclgwcGhlT5pDujGEo3kivZAZp8urD9mJzS8xfWFETSiBxK2MpZAPkKGg+sCDChC7wts+DcsLcs8nZu/xm83obPi9oHY7G4y4NALg0cCPDbzX1BfUciPOia8IeGRjFisYxgwT/mWN/nSYsvOrKYkN9K+vNYZ2GgGigQl+GS3GNPlQ8AbNABsxr/Ts1ThNGje74A28lcTCb++hexA5nms46wpVlkLEddoLXCGcVBC/co6yYvoZRrk/FfzIpEUaMXOi86mnM0D+f9uUXRvbu/qwwuCBdPm1PZvxdPjxOqcAqeyEQU/FW0XyeLdUInWy6xnrgnzyz2dBdJ6cajsQ+UgcdCW+mB25HUbKXNwzp/xGjQA1RPug1POWJAs0qfcvDNpKPvODgKw5ueMCst3DbRAr3M5FqJKPmD0w82j8P9sZytvWTQqOjcEcpKKTUHQCA56y9NeTwu5gxX1GA2OWYzIgqJQmAPOMcJlC84u1a+QtporhQ+QBmmVJq9OSgMxkKtGZJbGCbrOwmi45f0bk1Ymjtpj4RrdJsOjIy7ue5EP71afBcMvKwu+JyteYVI9szMEVQK3mpFYUCOAwX5Hd9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(52536014)(38070700005)(83380400001)(5660300002)(55016003)(2906002)(8936002)(33656002)(7696005)(26005)(6506007)(53546011)(186003)(9686003)(66556008)(76116006)(66946007)(122000001)(8676002)(54906003)(110136005)(508600001)(316002)(71200400001)(86362001)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+e9zniMQyjnJkFZLmDhvCuhIL9Z6hYqvdzliSUI31zdwfy3kFJDE+hcECdlH?=
 =?us-ascii?Q?99IFGMNMzok3JCfqG0URwsmtWBW+4YqqFO8htxwy+oEoHA3fXSPAzmIErqhg?=
 =?us-ascii?Q?RmAWbJjNQ3D7qf/+O1RABxIpRSc6ekNPX1VUGKRQyqs9DzOd/ltJZEB0zGLc?=
 =?us-ascii?Q?OZxo4m8xCtH6b+QWQup7btdR0AADC5Ri7RhZYvNWpdrnTiKg2G1D3iB6Y/ha?=
 =?us-ascii?Q?SG1sHJGxXPXg30s477E9VBZvFZ2PojI70uB+XLsUIsReXDpJJFJL/U0F4XSy?=
 =?us-ascii?Q?Kkz2FTTmAZ3Wz4NXl7qVr6YbLEwYUQeNKy2PlxqVZ+/O4J4If62YKMfsior5?=
 =?us-ascii?Q?+xjCAxbni2hWm6GZGPgC8Fsw3EnoZgTCKe1Bqa46otnuMdxvaVzkt6BIsYVv?=
 =?us-ascii?Q?O2nbZy62qZV2IyZoY6PGkJPk909HTCaih9XFYlz2XCXLALNgg76jm1DpcUh7?=
 =?us-ascii?Q?lKUceOwHX48E5nkEKZgMjtH748Kz899hbQt8v9URge5QDVSav9mhCpqg3VfR?=
 =?us-ascii?Q?+wyJgCrLiyJvZGylrvpgEhya5tFtG5BIs5PzgA/JCNCltJU0kdcdvDtWue04?=
 =?us-ascii?Q?PxVMXyqi2ludEKZWfyyfYzp4zZyL1aYWe6FnBTPCM77sXFcuSrL2Bh0CbsVc?=
 =?us-ascii?Q?fBA9ZNCubnZy8vXVZCd1VArtJ69uXotDYhnvgxNZ3y+aXjb4DwvU0YSXia5t?=
 =?us-ascii?Q?3vCMhv7WUzs857da/cJROdXME7HrnoKk6LC3JpbXqywwN78ND4VNEe2bMyqK?=
 =?us-ascii?Q?6fITOfEFhK6IO/W4OYBl03Cb5iDmw6cK2T8MFy6XIC66cW01KrGSVHHQDi7p?=
 =?us-ascii?Q?PT2ewEYr/cRrg5fynVXwicsjIABngUdJ4n5ORfD/kKEahhfaG6/Yc5IL9Xy0?=
 =?us-ascii?Q?RxZFNPh1CSpqCQCFLCzJ/ZtZeNKzmGamKmCHSvHOQ3Bf/6j/sAv8hBNS67pb?=
 =?us-ascii?Q?od78KlCiR7TM36SMbVOTOeLVw1EnMsTu7QKcz7TscVVYaTMlrQtpucN9LAQH?=
 =?us-ascii?Q?TXUgAudKVl46kS6eJ09MHG874r9bnSQ0OLnSaINI91yKPHqQD6wjFTplU3v6?=
 =?us-ascii?Q?9DjChg2RW7yXNcWgRuyLHrUZbZBECwg27wTqOhIsb+WIjXAopCahtdR4/XXV?=
 =?us-ascii?Q?HV4Tq9ZAREOL8eRjhP0kfiUkVTHT95t6CPRQXOfj7Qw2PY4jaRhd6n14izdJ?=
 =?us-ascii?Q?B9icuwwAVdeVjfBZ24kE6PEOr5G8BVdhAoiHpDuVl4xz30cyvnYosjfKT1TS?=
 =?us-ascii?Q?m5aaENuyMf0v7UIe2b8LAuo4Y1xldiVJ5ZiSytu8KxQ1I5MJTygj3npfC++n?=
 =?us-ascii?Q?6qQznEdX8ko+0kLjmyBx+O7zBuPcxMlbEuFRSpHxcysFhR3Q+0Zug9ZMUnEA?=
 =?us-ascii?Q?VeKC5ieihucg894+zh2LaDHcvHZo5DrnMA/M9kSYynSFIr1nCdvrYKdDvJDL?=
 =?us-ascii?Q?SnVcZ/XwN9wEUEfqTiK/sfqofaTZgwBUHKFUAKKpUDFI5tkwgAWUsnn+18jE?=
 =?us-ascii?Q?vf/ycwsH61RV4AIloM9+PryYaLoaEkk2Z9fINsiwrH+4aArX6UtGJDRvwbk1?=
 =?us-ascii?Q?GijYNTe6CarjU91WBng=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6f867f-6817-4864-8397-08d9f5ded5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 08:39:26.1447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOaEYaNFPsvnqUhPJcJ6jSXUoJJXRKBw58I0iFtEgNzlkG2QpBnrzvlQuWbc9Ois
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3779
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

With my inline concerns addressed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, February 22, 2022 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Fixed warning reported by kernel test robot
[Tao] "Fix warnings for RAS reported by robot" is recommended

>=20
> Fixed warning reported by kernel test robot:
[Tao]: Fixed -> Fix

> 1.warning: no previous prototype for function
> 'amdgpu_ras_block_late_init_default'.
> 2.warning: variable 'ras_obj' is used uninitialized whenever '||' conditi=
on is true.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
[Tao]: "Reported-by: kernel test robot <lkp@intel.com>" can be added

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e5874df3c9ca..a73567ea03d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2400,7 +2400,7 @@ bool amdgpu_ras_is_poison_mode_supported(struct
> amdgpu_device *adev)  int amdgpu_ras_block_late_init(struct amdgpu_device
> *adev,
>  			 struct ras_common_if *ras_block)
>  {
> -	struct amdgpu_ras_block_object *ras_obj;
> +	struct amdgpu_ras_block_object *ras_obj =3D NULL;
>  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>  	unsigned long ue_count, ce_count;
>  	int r;
> @@ -2456,7 +2456,7 @@ int amdgpu_ras_block_late_init(struct
> amdgpu_device *adev,
>  	return r;
>  }
>=20
> -int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
> +static int amdgpu_ras_block_late_init_default(struct amdgpu_device
> +*adev,
>  			 struct ras_common_if *ras_block)
>  {
>  	return amdgpu_ras_block_late_init(adev, ras_block);
> --
> 2.25.1
