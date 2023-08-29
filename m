Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C44C83F12
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 15:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9581A10E3B7;
	Tue, 29 Aug 2023 15:26:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A3110E3A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 15:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB4YNC6JfZ9SvDv1LQUemI0sWioP5XtYkxo0QJ6bS8lfopbTarxH2zK3dxUMyxkWcZze0Krv2VL7zk/sXIhxoSmftQjn0jiAUDM/E7oaMTHlS3AKZzoDA8hpQ84gCV/geEWMxZke1h44TeDeX+uLXNY1CMTztkgtXctKA+gEFnoKeMCu/2NHpNWXIgPgttDbddHVsttXNlW5rz4SG6piZZl+bcuOrqIMIWeNojrVCmwPNU7/8F4KSfvb8sH/aK0hXOFIEGYzVSpeUMKqt59sgGGExQj1qryZezA6l5Tb0EW+AzXpQNPRwyYd7PyMEHN9+EsbVLHUOAna7BdzedLxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jmpYEiM6QDQA/RIo8q5lP7q81JUinrfsgJI2DG1J9U=;
 b=WqXq0M7syXbJMJZB7IffWlW9NJwV2KGea6MHaMfnlYKaIjV7pntUa4vl8SbBMlm6n//lQHIFjBNVdEElo6419jc/E7TCnyshvD2lVRyC5/vo8hEt27vMjn3Z48Pdu+lroptr9Au65Ddgf2T3NNEStL+1dyj7KsCQ572wbtEVkCNSw7sCVrr01GjCQ7MEtKA2ojsQyajJcI7sN2m9Nz85bwTfle4HGQNrsJsiZgGclDhnMJZtpqUn4O2QOcL6vzaoocYkr2VAaQBKKgHwUb9/pmSN5sPHY+4h3dknf5LLraXwE/uh+1fZkaue65HXleQ/hfU0bhh9OGExmKhGkZij4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jmpYEiM6QDQA/RIo8q5lP7q81JUinrfsgJI2DG1J9U=;
 b=XGNa7UbOegvVNEj0eHa+nVQjvqA3U9EpDipZeP/ZvKF3pCURxuV0ITrhTbcUTXMOh1/49jLXoBgF5zmxHnBJMSiicDDhnrb+lodoBlJ6b4q/zQGRJ9aeuxEdKIGnM7G87infCGxGPoDCumIWovb7dLsBvbHC4HY7+iQSb1siZE0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 15:25:59 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 15:25:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Free ras cmd input buffer properly
Thread-Topic: [PATCH] drm/amdgpu: Free ras cmd input buffer properly
Thread-Index: AQHZ2ojifqjAj+csZEiIsbZ0muv6Z7ABXfgAgAAHEJA=
Date: Tue, 29 Aug 2023 15:25:58 +0000
Message-ID: <BN9PR12MB525717CCBAA592C354D90593FCE7A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230829145525.30096-1-Hawking.Zhang@amd.com>
 <BL1PR12MB5334E1662CB2AF3AC12AAEF89AE7A@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5334E1662CB2AF3AC12AAEF89AE7A@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=46e4e03b-bd4a-4c29-935b-1a4e9cbdc0be;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-29T14:58:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB7602:EE_
x-ms-office365-filtering-correlation-id: 3f633eb4-fdb0-42d4-0ceb-08dba8a43f0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jO0GCNW/xPrlnij12Y0lotGl7tnsYs4UKT8ciDCncL3E8C7Ot12SEgB78OVQxpbk9UCUowABoG7AA6CzJ8JpQL++dUkMAxWuaRRyiC1hQrY8zs0OURi50Q5Xc7vQWfLYflmT3HLH+yNkYNPBegsbQUEIy5m6urJQnFGd/kCoUUN4k1IwLcI6MyozNEVijTWEYp8qEmdbeQN+kbX9DKuO0RDzgfhkbW7FGb2vGJlFKsKGV9/F4ZrWZM0wghSpCpsRtG27D7io43eCmHQ4+fJsyGCEyDv8n2Pxq7YvTTyARNC3BL/xtOSaVqbnguOjJSgWaKK0UqN5J0QUB768UlisadhoKunKrmmWf9WyexPWrIQ4PyP503Fe1jciqTi5UbMiuF6So886oHoVb12Sybd4w7rYZZ2C9wFwh0VBMXRFykid4AqY+oc8FhpPWvEiyb6NiUe8tWgLf9ue9uL0zDoUe9vnooMLiVmDNKl0xqpY4bQVgWtzUzQ9TkOaspWiwtYtZlEYDfInerFATtJZWA7Pvut10UlbGKtG3J/Jrjzk679VHX8zGkum5ZkP6XgTetmsza/EX0/85xAxTDSO6ferYxWKInntneyWJXN/X/xAY1s55z9rh6C/IKbZWIUCGVSl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(66946007)(122000001)(110136005)(53546011)(76116006)(478600001)(6506007)(7696005)(71200400001)(64756008)(66446008)(66476007)(66556008)(6636002)(38070700005)(38100700002)(316002)(41300700001)(9686003)(26005)(8676002)(5660300002)(83380400001)(2906002)(86362001)(52536014)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T+BpnxKqCOHVs0UqRAAat3XwF1+xKwulejdC6KF35cV3D+leK6kjjmYpEOaT?=
 =?us-ascii?Q?/50aARJec2AQDY9wfHInStsRo7lNzwuC4jESrfFmKELp4pZqH/t9tDF/O1Ql?=
 =?us-ascii?Q?26OUAHKhmCnskq5eZKWAAF4bJnZtsP1+b+q+0F0Wx2guQzXIzd08rKWXCA4n?=
 =?us-ascii?Q?nKPE679Sk2AMwVFtBRbMcphwaKRaY1RP875znEOivWds5Uny/9aQfMR1jgfT?=
 =?us-ascii?Q?1KaPjvR9MgbfFeo7LSPzvrXEbTWMP8BPYH9tfnfJUjL6lNtjtmJJt+ZRuzDC?=
 =?us-ascii?Q?1lN1URSL5rM5huYmxyGzukXJ1hAPAzokmxipHS3HZyjx3+L0mpUOyrbK6NRJ?=
 =?us-ascii?Q?tqGVmCEMlRqjZqHZRtnSYVWnRz7MYhixGR4Hr8dxYyLYLRbdGtlzjquuOS0E?=
 =?us-ascii?Q?gkHKrdSy4paFDEwEjIsCOSlydt0UQqDDcRMks/N1/uxOaosnh7rKa/OhhQUZ?=
 =?us-ascii?Q?3XRWpOVOqPKW/mGmJNdVVTfryhiL54V1eulAb+QLLoOLIvfvo59ZDntPvwmO?=
 =?us-ascii?Q?hDOTo6eiO3N8d3Uv/scywPpVsBVyGPvWjfAOQYY9fOd2+YYeG5WzePOGJDke?=
 =?us-ascii?Q?EXui9jRAumVPG66Kpq5KSEJP1X1ILhn/3csnV8RbBqnUz7v2KqDUtdgagMdR?=
 =?us-ascii?Q?TrdhkUpVZT+aFpaYjTYGnypv28T/0Zyb/ZP9ZLT9+ycBdTUsEK1tCTbrwPCB?=
 =?us-ascii?Q?5wl/9LncAzRgsl+YkcdNNO+V0JYeufw+QuYzcDEYv2ytCTdtUSZPQxjsZNBb?=
 =?us-ascii?Q?y9AROtD6NDTrr/RWqrX+nD3ulpbJ9+D/hVDAGjdjx5P9dFHoPMOqyluOqfOX?=
 =?us-ascii?Q?/zhr+qfoZJuEusz281pXtFUgYqtMT/tX2mmtues9ci9G/MoG1ijKNiV+Uc+/?=
 =?us-ascii?Q?Rln3AqmJ2LWpsUhk2n+IlQpel09Ku9o8G2bfgkeYhEKsRFUoKy7uRd/rNolI?=
 =?us-ascii?Q?3V0yo6k9eO7Q8/WuyBxS00e74NPdUPWggqUL27LX+f9h69Lv48ZwDsoX300T?=
 =?us-ascii?Q?SOOjVfH0m+FnDn0QbNRuWbZx60T6rSP9nCf9tSs/mBRq3zN9aIh9rW2P7qjJ?=
 =?us-ascii?Q?tS7GBhXMX0uui3hDleCNV7I7TIrdHl6XuHJdpQGfPE1tJICiZi/Em1k7qJHZ?=
 =?us-ascii?Q?FuBpHZx/F+5bEbhZ7wVxKdGgUY/0yqGFvifTFpXnlEM9VV0zvBhPNWZ0RkHU?=
 =?us-ascii?Q?VsLj+fE38A2tolVO5xkIZbMQ26b2R0ubQUOh/FOsL+bSs4xk4BA754mcxf+i?=
 =?us-ascii?Q?BcDY2AXgWha4McVgL3r0ovGs8IdjUKc0C3m5+sNeGI62dNJKdjuqGNUBNFle?=
 =?us-ascii?Q?KjereZkkSO+hx2uSCQYKmSnF9P5Lra27jdjALWEwmVEtBsAivJELjZ6dPtqO?=
 =?us-ascii?Q?RLcEbVgpGSWYNcOJXXfVF/RXCP+ZFYEILBJpaqprx8nnwHuBa9FfoHenEB5m?=
 =?us-ascii?Q?R9AdRQoXd8XEN4SoHml9YMCWgvthWK0ivZTblRIQAnKj04e8yZ10pXcuXULI?=
 =?us-ascii?Q?bQ7yuR4o1PP24EoWiD94CUWAJDjoS420eYRIFOAve0Mnh8trU8CilZJ+hqgw?=
 =?us-ascii?Q?tX12Z33zJATyEmI+poo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f633eb4-fdb0-42d4-0ceb-08dba8a43f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 15:25:58.8697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahqbllVod6+SPhqMv9Aycn9jzfDr6/eTTNJJyoEvzTyhbES/a+OqYBMCF9e3hCUcCy4pveq1jtLMaxV5A3MaPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
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

Sorry about that, will send it out a clean up version.

Regards,
Hawking

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Tuesday, August 29, 2023 23:00
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Free ras cmd input buffer properly

[AMD Official Use Only - General]

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, August 29, 2023 10:55 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Free ras cmd input buffer properly
>
> Do not access the pointer for ras input cmd buffer if it is even not allo=
cated.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e47600a8e88e..16c5fe487ea0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -804,13 +804,13 @@ int amdgpu_ras_feature_enable(struct
> amdgpu_device *adev,
>
>       amdgpu_ras_is_poison_mode_supported(adev), ret);
>                       goto out;
>               }
> +
> +             kfree(info);
>       }
>
>       /* setup the obj */
>       __amdgpu_ras_feature_enable(adev, head, enable);
> -out:
> -     if (head->block =3D=3D AMDGPU_RAS_BLOCK__GFX)
> -             kfree(info);
> +
>       return ret;
>  }
>
> --
> 2.17.1


