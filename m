Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13D2C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 07:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25D610E03D;
	Fri, 10 May 2024 07:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PXuw2/0";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A25CB10E03D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 07:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNvnnNyuRwK87ypXTI9FVQsi/JlhPW1YtjKY6I6IGjY29/q35iTyWn38nggQvJLk19MtYDs/vY/WixrNHmm6C4OKP4HBrgG3+RTUTA42pVTqFfrLH0t6Hu5lwVQfeTAVXzRyC4V/Af97YHV8VEYFoby3efZCV/zSKgnRAMhujAHRK9kU9VYPJwl5ump/2Auq/+uPXXvQhm9msFBPzQ9HaqgLcghi9Ud/N5ZXeENsNeLfDVClsLnvAVht4W6Z19/dRyrlIyTMyWwaDXuTrXH8e2bOyiflfJp2DjFQHLrSy0Br4jIhY/JMfKMChdz7/TzjQgEfwJrY8uQqKVTGRTCQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTo2rQTym1tkQAviCA+H2SGKWeVLufYgZioQYjcJxSI=;
 b=PmlN7eitkDPa47y44RzciGeOvSy8tGoO8qOG/+g60KUf/QJ5V6ENjz/7d8Ox9MR9Yrl2htqjFdC6IKMjMWPkJxqLdFoJfRrZyOvHveuQgflh9p8jDVTA87+ZaxMADJpHB601pLeQ+0u/KRoqhsnr2f0f0sr/m1Wm1DeOhWncwst0ox0BrY5IZWo1j9nAeeMTA3qDrILcpchzc2yWPDQYBpibSismvLXs/M9gW/avFfqD8d94mDMCu1ltFB46Y7fN8SqWe/cJEoOegfJuDlzjhWV94Bm4AM3hqsrSFZwPbS4A9QxUzCW3knTiqdNcX6kMWCPPEl23eAJ4rOJSVE54Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTo2rQTym1tkQAviCA+H2SGKWeVLufYgZioQYjcJxSI=;
 b=5PXuw2/0FJ+JF5uYue5oST54N8ucsixf46PEjHXtIl+tUqHK5X47t+Iycke8SnvgrIuOeBGM1HiXozH7lQU/uyQ9Pc3YziQSRLsss1zGfB07cz5+zYZF9QZ5aC8PJQejjjcUwmNJUGogDUQdq0UwUEQN2D1hRCBWVtUVQu4kMik=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 07:41:55 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 07:41:54 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 06/22] drm/amd/pm: check the return of send smc msg for
 sienna_cichild
Thread-Topic: [PATCH 06/22] drm/amd/pm: check the return of send smc msg for
 sienna_cichild
Thread-Index: AQHaooUeCYF5YLzzkUGnIMFivck/K7GQCgpA
Date: Fri, 10 May 2024 07:41:54 +0000
Message-ID: <CH3PR12MB80742C6759C358968750D462F6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-6-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-6-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=eee5f5f0-abc4-4eb5-8308-61b9cd97a558;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T06:59:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA0PR12MB8349:EE_
x-ms-office365-filtering-correlation-id: c341a4c4-eab7-4a32-ade6-08dc70c4a9e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BnZxDUcu87Q0PHkbkh6T744PJqdLNFj5g3rqWGmFskngjGnI6EFq5aLqOD?=
 =?iso-8859-1?Q?ILP5/BW83XUZlNs2JQho7uGw5/daqtEcOXM3bjEBnezi2CfF8BErIHokj0?=
 =?iso-8859-1?Q?PdXntUYaGZLw2RB8wjfy5ImSBJLmgPpes6jUW48gEqh3fSu8Wp/I8yfOK5?=
 =?iso-8859-1?Q?R8EZmJOtfI/fSFyzWwwlpWtaYdpFqt1gqyTb4bSRws/y/IRtXBDTUk0OnB?=
 =?iso-8859-1?Q?19jk3f7z1Phz4SaYgeBkXZ2Y5hF9XUTLYlFtz4ImspdVLCGUTHtBkoYmnx?=
 =?iso-8859-1?Q?7US4Jr3XrFRQ62DIxEuWMra6bJPtNHVVZBB0X7z7QO2P+WZZJjSixhDWG4?=
 =?iso-8859-1?Q?NjJc03td5QeX2F6xcMRYzEQP1Yq2vc6UlLV8XQfi1TuJb+kztH7k1Xq97E?=
 =?iso-8859-1?Q?FuxCMuf34na1gbFyUF78HhnNFfc+0bFs0m05YGcbF+WTneXKCbnWgF8DnC?=
 =?iso-8859-1?Q?8JT0YvbYF9GXPf0PIh4DKrsN/GeWEW1usq5dYqpepyxl9DgIMYSztm1EZ1?=
 =?iso-8859-1?Q?ZFd7Fuk1YRuanxvy7AHjzHThJcTfBsEokNMvIc7Ymxh+uAKeln3rgprAo4?=
 =?iso-8859-1?Q?wdwqSLo/qeEpnod6pZ2zWg9q3amwyB7bCONbrBGx8Fo+WDsOEOgwQF4PUH?=
 =?iso-8859-1?Q?d9dBD06KFPrGQlCnuriPeMciie2+AXE3KnGbe+RvaUqxhgoWKBq+0XijTr?=
 =?iso-8859-1?Q?r4vuiV1DU9/e+DDTu0elhxJlQ0pJzOE5t1AddoXoOsEjKiJ5xX56tbHzib?=
 =?iso-8859-1?Q?I1Vi1S8xXdowWL0hMPNtOFi16FqILD2VOOr8A0Qi4kFeIzGLbWAYOQ5iL5?=
 =?iso-8859-1?Q?DQ+rp7wUIu9ydA/HSvIEZA1dwUQZYq2y1nLvVlJwjTOae03FjmOtGF2D9W?=
 =?iso-8859-1?Q?Y3YCgn2Xe3TwHvzcIhaCy0tqroNoZCEcq+g2FdBxCAuIjiKhF2UGs93Vse?=
 =?iso-8859-1?Q?mzsWWO+OZkYFHjIIFfroKIeT0wYifv91xWDrQxJ4NRq/F0mG2KInld4HvM?=
 =?iso-8859-1?Q?0I+AIuCk6sms2yOXRp/V6WQVKF6JYgZKPNCGZCdhBTRkj05yzoNufVY1oT?=
 =?iso-8859-1?Q?gOAdfhf42ByZ+tSurFBrZniTzbvShaP22DbLkRavuzzOyok+HvFhwBpI5E?=
 =?iso-8859-1?Q?02kPxkgf4wyrTmrWUzjhAVZcU44GCRN59pM+2BJXAMQVEOK9XxcWFvqcnr?=
 =?iso-8859-1?Q?1wWHlSsvbM5nKw1eWtM5lKV7bPBRkFzGvgPUa7pFWYmL8s6B8maOXktnkj?=
 =?iso-8859-1?Q?P8f0vrVqHfUoGiloF8k1NoLz7oawjnRFqJnmNDqcP0Y7Xp1TK5QCLLS/X0?=
 =?iso-8859-1?Q?hmWR7C1hgPH5Wku4HEgs8DJOGhu2e0at02+3WLhVKN0ktsX8Gy6WqFUI6H?=
 =?iso-8859-1?Q?wkipUt60Wp0hH4fYLFSGx/vBpmcHcblA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8dfIeGEIsXWv1/Auykb3cOzfwmw8E5z9wPDxPUkGE2LrJNCFAsGlAgX9wD?=
 =?iso-8859-1?Q?XOh80sGPdzmbuC6/y7MYIT4A70VznmDDru3NyCe9HF48aY7EmHYpsRoH6D?=
 =?iso-8859-1?Q?nwXw/Q7K8D6PPK5BRdb+iVT7WMeExTbpnCU5wwJFTSsJO5clH8gQiKDWVH?=
 =?iso-8859-1?Q?O9yAq2k2UgmUsW9TdbEiAYYPDABy/jrQ6NJZKcwD/VZZ5fktkhZLae+Cvw?=
 =?iso-8859-1?Q?MbXtu8VPhQLkBWjXRnZrAxhVUB5KnoYMhTYoXojGCho71BfZy2VbDWeICU?=
 =?iso-8859-1?Q?3wxPOOwwoEpHRpJCc6iVmoGZYGWmRm4PFsQ4GBnmRo5b/r9vXoRQ/atYOL?=
 =?iso-8859-1?Q?5viOUxnGLLfFaZywb2Q37+aKeksu8fDy+FOcR5jZETGhUnPQYAeyl9l97F?=
 =?iso-8859-1?Q?8lKK+cXObw/N29dM18efd5MbhIrx5xOU0axO4T4x663rDuCPBNAyRJniT3?=
 =?iso-8859-1?Q?mliTQqXhuwne5Jrzwfq46plll57mIdA3SuBahp4Izj1ilGWYCI+P11O9ut?=
 =?iso-8859-1?Q?iTg8iXfM4L6QpMzRxCUeMWp8goZ9vNo+CUkm2dFMeBGNvC+weBNU9lpHAJ?=
 =?iso-8859-1?Q?Guavvo80mTRBPuzMcPf15W/wpZ+lf2vAUuLsz9oAIdUmCkvJnUktG5fOSo?=
 =?iso-8859-1?Q?0ZuHOKBpIa2MlZD4Yuoo48DtehaPzZwsXb1GAZYJm0gBb7cBqgFGZYclCa?=
 =?iso-8859-1?Q?De80/WrfvY50gPQEIPjJ3axarSFuclfUXMrgibht1WXJXpBk1iiDYvMY8p?=
 =?iso-8859-1?Q?L+8XeL1l0iULEEvkTiMC0otQlsdJbAzeHuyU/41uLIxGCb7a2H7x91u2WG?=
 =?iso-8859-1?Q?z4+ceIq96b68P973coyDcHjuzr5XLCuZzKM28eGDvjUtlGr8H4/WNH06ZA?=
 =?iso-8859-1?Q?EslGRU64qv/7S5AWtL8N8WiV0SNfpoxJiV73sb7L9q+/DfXZ5zAu9Ax09c?=
 =?iso-8859-1?Q?+3KYB8ZPBCk0xkK6ExrnkEROH6x5SV/yXj1q4TxbBWGaN9VAaLo7McG0uv?=
 =?iso-8859-1?Q?o0udA+gGbBlMEDKsMt8aytwqrZFcz37E6T4fuwIgyUSaaTxY3lsf3fGP5J?=
 =?iso-8859-1?Q?SE3V/qj63kqWHCkyX7mVuKRF9FdR5eL1+XF+pndf50zvqWRkA8i36VEF2I?=
 =?iso-8859-1?Q?geOVa42mwhA5vyxf3i3KdFZnWVttLhlssvG6FH2cMHjdMARHmYPv9KXZMi?=
 =?iso-8859-1?Q?xksCuNWvkkwO9pMoLeo8oHm1e1oiu9NWxZvONWtK+jzJv7q6RisIZmRudd?=
 =?iso-8859-1?Q?dghcP2ByDOwjxt07gy5iGbdZd2FFPlW3n9KJoMWfUsHXosNzRJlhtcnr5H?=
 =?iso-8859-1?Q?ra7DrWqHYvxJgUV97cBzzrAUdsf0mtwa8HLDL3aE48OJX5+BTtSHOvClzq?=
 =?iso-8859-1?Q?yXNWSXSD14o6eM1gAXR8HQJ7y1aS5a8CBzzWv2NIG5k6NXM0FtUeXLp8bE?=
 =?iso-8859-1?Q?nFIcsY1GrZNtexpA26FlaBnwz0Sx4muAyWGyU4snwIdFmSMPJIGEOC+LUQ?=
 =?iso-8859-1?Q?lhB5YZX3Z0hOw2l4XI1rKHY/3yvPtdlvKkojIlfW2wLtLIiFySVo2WiaGt?=
 =?iso-8859-1?Q?ukJdV1LwfHwGEE3y2Kkc+Nr+9zfJorqvVf5bB36TKRKfKQh4FTPLQsiDN2?=
 =?iso-8859-1?Q?3334qPPydb2ofp/kDj91OzvkGrMQ4fU6qh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c341a4c4-eab7-4a32-ade6-08dc70c4a9e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 07:41:54.6153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kOBoukyQE+dtfpZrtPBLKzzMVNvl5Gw8uKHRUIvpwNJ9Ppv2ag5hperbSi1vpoCzwcZ/TqZedEqOCMJaM1caA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 06/22] drm/amd/pm: check the return of send smc msg for
> sienna_cichild
>
> Set smu work laod mask may fail, so check return.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index e426f457a017..e7ef8cb3a791 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1782,8 +1782,10 @@ static int
> sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>                                                      smu->power_profile_m=
ode);
>       if (workload_type < 0)
>               return -EINVAL;
> -     smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
> +     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
>                                   1 << workload_type, NULL);
> +     if (ret)
> +             dev_err(smu->adev->dev, "[%s] Failed to set work load mask!=
",
> __func__);
>
>       return ret;
>  }
> --
> 2.25.1

