Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB33C47DA2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 14:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E291F10E563;
	Tue, 16 Jan 2024 14:15:07 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8080110E56D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 14:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkPCGDYwFXM7FePPBfhAYnIvVjONlbcsajcND08h43js5kVR5Lb1O9sYNykKNIIUE6Ke5zt46f/JRLwICGAzFuwL9eKsgfng2dWI6GrWisGINxae3Aq0mvURr9hnrl6y62qUy9v1iKZJOsLVG7ANIj5kCMhR23yZ5ELVr8Mo2+9VTQqxsGUu6xiA+VKjKZrly6cZ/ysiXscCWILqwmQbyxnB4FMqv3e0bHtAqNwitQMi518LBzYiqlYN48pXZbk3Ki1oqlsERO813WbyN2ymDbfaPIoPtcoGveM8tbbCYq+UFUPPoai+wVVpfL1Pma7Cw8tnTUTwmBW0F0o4jUENiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J60J/rcKdu4AMStKNpvvDxGqnW4g50q7QKjWH9b5q3M=;
 b=HQkfInOOnAvjN3v/9ZfwxzBlJu/9bCa/NLmnT8pK9MCJPmJG3ej9dDXd6TIO2OMjK/yObQRcHptynJFrpQCGeay5mS1dApd/poT+YhkVMfEMllDV7L8ABsfWcr8wOJZL5aE23B0mJeoKyfGo/Q/Z1qxKH96rkAa4MdyQUW46HM+vscm2Ksuvq4grXoXjZfBMsoFbXyyWl2FEi/+hijRsQTYw3O0fd1BOu9YmQuf7UXiIiV6WfQHLLH4g4zRmEkGEthpgvcQrGPAiepjXFHDvpfA1HG8BhpJ1pXw7ox32KPgnuaHZTSy9PBKof6DGKnSsHkIWx1MGW2ATGr6Wza0yFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J60J/rcKdu4AMStKNpvvDxGqnW4g50q7QKjWH9b5q3M=;
 b=FF7qaQinVdXLCN/XgYXxTo4fCpyYdu8ACEASLJBuOg17U2Vqtum6UXeIUAY0GUmINF4Xyo1yUJhedbviy+A1DD0uNtslxJLeYYVex+1kqmNS7aCVU072M79+IjySUEkCA5ErrGxjL6OdnS7pYlSOZnlJosmJLVFGp2mr/YuL3PY=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 14:15:00 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::ad10:67e1:3ab9:264f]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::ad10:67e1:3ab9:264f%5]) with mapi id 15.20.7181.015; Tue, 16 Jan 2024
 14:15:00 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove unnecessary NULL check
Thread-Topic: [PATCH] drm/amdgpu: Remove unnecessary NULL check
Thread-Index: AQHaSAZPhSKTShIGikqjAWB7dbGVrrDcfK7w
Date: Tue, 16 Jan 2024 14:14:59 +0000
Message-ID: <BL1PR12MB5898B88D857E5D419782DD5C85732@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240115225727.1287832-1-felix.kuehling@amd.com>
In-Reply-To: <20240115225727.1287832-1-felix.kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=42b0d729-8d6e-44dd-80b3-80e304ce15e3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-16T14:14:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|IA0PR12MB8351:EE_
x-ms-office365-filtering-correlation-id: b6b2f980-839a-4a11-14bf-08dc169d865f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEB0PHQU1iZPXrOF9gI+cAHtsDh9ZlPy8mgKcjorhhegM13nFXZVk3gKR6si/FB1pyojZud1fWoq26pfdVRh/O0iA8Ao07yH6xxMJa7biJNLd0ZERXIINztzhKcoOJ43wCcJP9ReYWyIpITOl3V+ddGWMlT2bu+bVvpU3IgMDAwXxzf0my7skZrL8uoFusJSA+OMRfr4NUix127CGpN3pWKMvQSi7uy3iTQnZNnWZiQVr2jCz+2mFgD0Z30njsWMgSHoud+ivEctKmGJbJkDHsE85fD/eJOJUSsc4MGJvp2kesC63gGBSpc+fiIDOVgquhWA2hekSxXZwRDe6c+1VIFzUCDMcCZodkHwbPk43GpJRXY1p1wjikCscSLTRrWJ968+9CXXzgoDA6dCDLBaF26ZHjg3GnlM4XF0CBSxuR5f6EuVhqy3b7gTqr71TJlz/wkUfx3QdHGpKyCBAWVM0xe2x6sZP7EtmdPYesP1Og+TPcXE1LSZjSc6NVDFzsBPyZz78f3anYg8C0QqQh0IpgIDQr18oXWWF2jnEvdzEmWj8mAnLqV/SWLeqkyin/DofjFeV3CMLAFr0PakDM82FC5ye8x1jtOKnZB2qCww+I1V3dQan0EwfD7axTwQPDlH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(110136005)(38100700002)(2906002)(33656002)(9686003)(76116006)(316002)(8676002)(4326008)(86362001)(122000001)(66556008)(8936002)(55016003)(64756008)(66946007)(66446008)(52536014)(6506007)(7696005)(478600001)(53546011)(66476007)(71200400001)(38070700009)(41300700001)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7gyPT5KkxZaTFCa4Zp5z8vxc5naDri3c+v63c+lR9q9R9vHY/mroYhCv/XL2?=
 =?us-ascii?Q?dmkammNya6+jEgannfYAWDHTAVha+Vv0m/Qj67e+hGkj+3yZUIJ3DQTZ8mwI?=
 =?us-ascii?Q?eE9HFEdO+UgamWdCE8vY/slZiVuqCbVZEhs8FsvmhLOKiWIwGjcUValCkXqa?=
 =?us-ascii?Q?0nWZCQqqBWZWajzfK4VdgV80zLHRtUzgHAy/CtmG1vNB3kg/Uv2N/I0ExyN3?=
 =?us-ascii?Q?YzizPPq40KvDqaCm/B3GDSDo8LR2phvitTOksd1FCNhu0TWkh5n8Vt0wyF0d?=
 =?us-ascii?Q?Lkf8y0F33jZTtTKscT6QTZSZ7Rx1t+VFqsc/psppvIs0gnEDpnJFnoV4IPfh?=
 =?us-ascii?Q?bftC8jOYtJWq6dr3DH7Lpa1tZPpUbPQ6AdSwGEvUe4KYr0ugFCf/ms7ybqfd?=
 =?us-ascii?Q?2Kiy5tl2weZfiEsrGW9p10aeuvhV5nyPZvP4F8xGTN85qtrPMJJyuulHmWgD?=
 =?us-ascii?Q?McwPjjQWO45To1PyW993WIvpa//kGs+eT1Bjimx86XQ3iFUJjuTywgz+CyLB?=
 =?us-ascii?Q?gy4Fe3xCy915PJPgOU8gexneAESvAUg6G0Rc3r7Njre8BudsixrmlXSeETIR?=
 =?us-ascii?Q?Nwp7R0rgiiCxS//YU46KlDDMB0md+OK0+nDKEmVpMDRQKn/rV6hpsXV0Cu25?=
 =?us-ascii?Q?FJHB8AiI2a+KBA7qVNcsRZYGEX0Q0od6Jln+ljw8hVqHtxOLzMPBwfo8pKcq?=
 =?us-ascii?Q?NOyzKFALPN/R4t9rsphyRQOFtgCdCO5vw/WAB3DSC4aP2sEEwS5SQjTkvB/Z?=
 =?us-ascii?Q?wwNbnjSkuWxeq7L/KYeHfei34WocLgCF9x99/n6rPDg1TvAs3lQV/BbY3Lz6?=
 =?us-ascii?Q?1PjbrrdrOlP0hMB2WFYayBmFtXRKARp7KRLXYbqh7El+JFWKES6ufKTu3Zcx?=
 =?us-ascii?Q?Fq+61VRfWq63EiHblS3mapmHm/lswln1vZIEJIe99wvJOLnhlS1F9SE+0/vZ?=
 =?us-ascii?Q?YXCo6DLXid06ESDLPawVyGnHyNioNtLIrmzOxml/hyDGOYbP2KdSgmoaM3aE?=
 =?us-ascii?Q?uqjxYaJu0y2iudycmspIyDWF8ZB4kzMUhFGKT81QP336sYu+mmJSmBGa5WVL?=
 =?us-ascii?Q?bVx3qvI6I7FAD3vh42N3HDAOA/TuSkMX+SDmEG9GAwZPThoa6RfCaK8zFs0f?=
 =?us-ascii?Q?wz3BwR7xkyJU7VSXpOtDkRgy2NADTkCTD0vtr+QEsYEIkTRZF9WO4ZVQ78qk?=
 =?us-ascii?Q?DDZzL/6AAzysmUPUCsn55R034f7OrQz1M4BvRfCiuo6BfOJOVGw49ogBUmxV?=
 =?us-ascii?Q?N37q1nEUNmFCZr6nii5zCRVSf/W3S7OpomYvdM6dSKm7Nu4zazx0858YK1A9?=
 =?us-ascii?Q?oHpoQ0Kjw542mMCSzMshzlW27bAr/22NIz2UsiJ8HmPIc9ClNrnlRAOniitZ?=
 =?us-ascii?Q?q3Z8QFnBjkWsqGDvSVRFG7oemrJjGq5hDskXFwkF7kv7Z7R5EsyDbXxcAQLx?=
 =?us-ascii?Q?u6i+cTKf2vSuVk4D1RVMvI8LrOY23xBEh+nFI2sv7HDQH0qK5+uu27E39MCK?=
 =?us-ascii?Q?2+y3v81WIZk28TQFk/kKDgefsdCOwyTxaXengZv8vOD30OQhUqnf29vwvoMY?=
 =?us-ascii?Q?O9EF37CQPtFViHF+2Zg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b2f980-839a-4a11-14bf-08dc169d865f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 14:14:59.9280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7iBBv7t2eRDg7AzUVNWNokLQbaztEpAtT8K7fftTAKtUdczb++KdoWJ7jMeizOXTwuzOKGMj53QVxl0Q1wFZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Monday, January 15, 2024 5:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Subject: [PATCH] drm/amdgpu: Remove unnecessary NULL check
>
> A static checker pointed out, that bo_va->base.bo was already derefenced
> earlier in the same scope. Therefore this check is unnecessary here.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 79e7fdec71f2 ("drm/amdgpu: Auto-validate DMABuf imports in compute
> VMs")
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 77d015ebb201..b7f07cc52b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1477,7 +1477,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device
> *adev,
>               /* Remember evicted DMABuf imports in compute VMs for later
>                * validation
>                */
> -             if (vm->is_compute_context && bo_va->base.bo &&
> +             if (vm->is_compute_context &&
>                   bo_va->base.bo->tbo.base.import_attach &&
>                   (!bo_va->base.bo->tbo.resource ||
>                    bo_va->base.bo->tbo.resource->mem_type =3D=3D
> TTM_PL_SYSTEM))
> --
> 2.34.1

