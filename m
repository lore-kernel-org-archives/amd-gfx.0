Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E9E10854CE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 02:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 270D110E05B;
	Wed, 18 Mar 2026 02:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6UQPWIV";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7EDB10E05B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 02:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVtb2o6Gc0UDApg+wOaWRQzjfwKamQvtLg3CmNWJ2xUBiYhx8yQD+i84r3dgj+4HETlIN4a78dwxnX/6Za4So4mQJ49a3Ac162I4RwXtBonPOMGod6hQFO5G/45yhUNp5y74tLKutbSXXIxT72IlehHT0Q61QWboSW7yIJb8U4HDWl1+0OppGqQHb3XxbJjp9jnOU7+8Axyc1mN5h75SXmgTb5zz6xNYkeYTOSxH3/3SX/q2td48CMmp5090ZU8baoq6jAMrFnJ55GqXNwok1a7Yy25u2Y96S/LTDbwFJVEEyEr/R7ItilyDIlQSMwaOwgsNVeX42bWdG69rYIECbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km7aDoDE/UF6NgBIEIjl0rKey3h6PXp0MIj7FuPlvNo=;
 b=YilPv9lglwWwfdZFJt+kNoNJWkrlN04uXVAxwu69/cf45Pa2fPC7D9ruwKrA+fHvpmboaUtrE96zBjrd+LR5OL3KyDU8SvS4sQnYd/pJC3W+9V9bUWHN4IQKNVWMWbLNKkjlWnYXbCt6jkH8/+5Sv4Hs942xVDvQ8eJl5CFU3UdWfjwrNbdNr9EN6C6ZBhiqWjaIQ7rDadLIRU8gtAH/vgYI+I9cIaje4TJdRsWDHR0Dpv00ySxEwphp197L1v5DieWMiMOkOxRM3NDZd0kjygdPwrowW3LGrrjhB85EKMv7wRGd1F563F8K8HafWNP2CJlqIrpnmaTYwxUmIIWhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km7aDoDE/UF6NgBIEIjl0rKey3h6PXp0MIj7FuPlvNo=;
 b=x6UQPWIVDnSe/THrvohYdgWgDXqwLL09jXrqqhOcP/MF/IuxmYpByiJfV3efX+47wUu+Llf/ByM6QQrTO1Es3VJAmqGgIOwd1QX8rT1OgdzldIhj+AAMAk1D0U/Ph0wpUUw7iT7NqlYjnB5G0l9G7zqXa8ybEtCzAvZnOyUf+Fo=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 02:23:03 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 02:23:03 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 6/6] drm/amdgpu/gfx12: align mqd settings with KFD
Thread-Topic: [PATCH 6/6] drm/amdgpu/gfx12: align mqd settings with KFD
Thread-Index: AQHcoQ2hjX9D0QTKUUGyVuW4u0Lw9rWzuM5w
Date: Wed, 18 Mar 2026 02:23:03 +0000
Message-ID: <DM4PR12MB5152FE6A816AB04E5D3EF9F1E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260218193416.1474441-1-alexander.deucher@amd.com>
 <20260218193416.1474441-6-alexander.deucher@amd.com>
In-Reply-To: <20260218193416.1474441-6-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-18T02:18:06.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PR12MB8087:EE_
x-ms-office365-filtering-correlation-id: 520f3a3a-991d-4459-bf9d-08de8495484c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 7vn6DMurYVzxFSxlMe0SH1gqHO2UE3C9tyx3EnqQOcRZtkPDwTC51Fnbf2L0AXgBKMv89+liB2ko5XyQlnjz0j5z/lc2zbCd4O5bx24RyBTJwP820L3pyJ+tSVzJoJlT8s/cQ8qohOtdssoS0u0nUmLodNH6Nijbk1mn7ds7YocZHA6Fl5VcCQCZ9JrVWo9wBb+GTD2c9+HLHOuTswgHRYfHCKj2Q4fQKC80Zy1dQGtRGZ6ZDzluv0/MaetB4dfx49BQDdqN+FveBjoOCkte4jGHziakR3DHPUjwzq8Wky9Z8bCPqqV0Fwwu7eyH1nhfkvEZDr+N6dGCcjajqxTRlpLVUQIiotGRF8CKS288Pr61i5m2oDt5Vfi/KuyqSaiAWT9+9t3PSQueW7tdR/i5b2CloVKRnFkbwf21xJ9Slpcxn4QTKxANXrm4WNKBomI5VvsNkLUw6i9J6AVvblY/wgTEOo4iB2247R0REqTlcy6QVONPlYkgOAnG4IkWvw2uoaXwdTCKH5AqvEq9EDmdi7Oewjyj+8UdW3G973YH0kyGESUBQT/N8hcEDTz7iJQLIoxc/81O2nZ7467B52qxwwBEwNGhU5wYmsPn8B6yPHCbHSGZaofwcKdw37iL3lcX+tKSs9qDd9/0OFVB5bFVjole0MgNDhL0czSyL9oB35g6UZmI0peT2eCgvhmxkDAkCLA+rF654lCKKHpPORyKSGqlJ4KVvGcBPdFdM+kciHABPUMz4VvY2weJOmKNk2s5dglVezlAVD5/QgWRhkW7kA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YmY0V0Zqay90NXpCSlVESWl0MDJXR0hDdDVlOU5rU04yMkw4Uml4QmRC?=
 =?iso-2022-jp?B?cHVua2RnOXgyckhWcTJiMms2aHRiK201KzZXb3kzQUltWmZmNlZvTlFm?=
 =?iso-2022-jp?B?ckxVRWVMcklwNzRjamg4VnNqOGRDaWdYN3FxdFpyaXd2NXlUdTI5L1Rn?=
 =?iso-2022-jp?B?VVNyemlja0cxd2NDRzhBRmxjVzh1bFlSdkNkNEFtOHlNVnlMNllnNkpB?=
 =?iso-2022-jp?B?MlMyK25ZV25LMFFyb21sMlVPU0lBMTVwb0tiV3hvUjlhSXVnY25xb2M3?=
 =?iso-2022-jp?B?R01jWFRRSXZ2T1pVd1l2VFNsYmNGSzg3NWhTblh5M214Y2lobXl3Mk9N?=
 =?iso-2022-jp?B?VE1XYWFJSndYQm9WbFhKUGVGSWtLbHNIS1poNlFYMW9Zb1p4RW9JSXhH?=
 =?iso-2022-jp?B?ZGEvYkpUYWE0VjZFbTU3SEYwWUxFZVA2MWcvYzJIdFdOR1dxVE1ndzk0?=
 =?iso-2022-jp?B?VzdXMzZaOHBFZm4vTE8yY01lNTRIVXRVMlgrYmlZTUJCU1dTd21FUnJK?=
 =?iso-2022-jp?B?VUl2VCthRVk3bXgwWFBYY3A1R0FVVXd6Z2F6TjlkQSt1UC9NcG9zcUNy?=
 =?iso-2022-jp?B?bnl2M3REM0dsWFo2azhWbkNMZHg0TE53WStXV0RmUUxsWHBvVlZyZ2pu?=
 =?iso-2022-jp?B?VzRrWDJlQ1FLYzNGRE9mbmhiMEYrSGtPaTZKSmhYZSt6bTl2M1J5blVC?=
 =?iso-2022-jp?B?dnJMcDhWMzV1eUNOcWJOa1NaMHB2bkIyY2hBYWJDNVFqS2hlNEhSV1VV?=
 =?iso-2022-jp?B?K3FpcnkxZURzNHdxUlNrWHRERDZFTy9takFtL2pFQ0E1Mk80MFZ6K0hT?=
 =?iso-2022-jp?B?MUlWVnhTZ0ltQlAwNGtlbWd6azh4bDBRSVFJQ25NV1BKaG1HamVsMVlO?=
 =?iso-2022-jp?B?VlNYUnZKSTY3NzI1RC9Ka3RFM1hUZy9OWTZoZm96REFnK2xwRWJ6VjZm?=
 =?iso-2022-jp?B?Rm5SMENhU3psUnN1bExtRHNrTTBsU2orRmtTeDIvZkpUdTE1eTM5RXZH?=
 =?iso-2022-jp?B?R3FXWkVZb3dQdEVRWkxnYnZTZ3RGc3pqTjFxOHFOSE1nb3Z3RGRPVkRU?=
 =?iso-2022-jp?B?N3E1UFB5Q09YV29FY0lyQU5qOG8wQnl0ZVhjQ1Q4bW4rVks2MmpmSUJy?=
 =?iso-2022-jp?B?bnJMNjZLeWlKL2pyd01KQlpqWDI3cXFLdkk2bVZQWkxmQlV4S1p1RXN4?=
 =?iso-2022-jp?B?cFllUVVwbTQ3NGlqY0dsMHBTc0tlZ0NaWWNnRi9rcUplZFc2Q2o0L1cw?=
 =?iso-2022-jp?B?Qm1ab2tyRk0veUVnanJFR3ErZFVEdHUvMlYxU0ZtYjFxcW9vbnhVNkJ4?=
 =?iso-2022-jp?B?TGw3bFFSQkZTUWFBZVdyR3Rnbk11ditBaGFxY3IzdmRSSDUyK3RubUNN?=
 =?iso-2022-jp?B?d1JFdWhRejVrUzZPOG5KYS8xUzRFZ0d2MFVodU00eCs5UWNrYkFLUVIv?=
 =?iso-2022-jp?B?VTZGTE9NMFBmUFJpVnZTdkNTbnpIdnlVcHZWRjJsZEdPTnMvU2s4Smo3?=
 =?iso-2022-jp?B?UFZtSTlwQlcvNC9RTStPYkswTjVMNmN6cUZjUGsvTTgwUnNhdmZIWWxz?=
 =?iso-2022-jp?B?YVZLUXlyUDBSeDZCQ0VZSnFMbWp5VjFKTmE5eEV4U29oTTFtSks3Vk9B?=
 =?iso-2022-jp?B?alYrNzVGMVQ1aHJZUVBlYXhZUG5sME51YjlDd0JxR3NxS1lGSnA5dDdF?=
 =?iso-2022-jp?B?N2duM1VrYzRjTG1WTVBSV01zWW45THpuMzBHWUJYOGd5aEh1K3Z1N0M3?=
 =?iso-2022-jp?B?T0cyV3F5dE9nZWtJbmc5WFl5VUZBMU9mOGducXVGcVJtUHVXaWdpT0h5?=
 =?iso-2022-jp?B?K0FyWVFPT04vcUxyTld4dnAvMGxtQXJUWlV5YWNVcjRzSVZ1VW1WNDlW?=
 =?iso-2022-jp?B?Yzc2NGpxa1luWmYxczRiVEtPOEdDNnIxQWRoUFE1SjhlU3Uwei9kcmEr?=
 =?iso-2022-jp?B?NmRmTUthYWlvd0p1ajllY0NIQ2N1NUZ4SGVNV3RjSkUyd29kck5xUVh5?=
 =?iso-2022-jp?B?and6TGNSWWtwQy8wME5aNUJOTTBuS0JtbGQ2NTZaa0NHWTlWa1NzZjRM?=
 =?iso-2022-jp?B?SG1nSStBczB4dnIrc1Z0Tjg2V2EyNnUxQjl6WDVxWlUwRVBiZHdDWVNK?=
 =?iso-2022-jp?B?OXVRZER4emRob0dGejlYVm1oakd1aGRoZGhsTXJTWDQ1NzVmU21VOXRj?=
 =?iso-2022-jp?B?NkdLc0JNTWpQOU9zbm0rRFQzMGN0MUxsYVU1dXdGeEFaUUlScEF1bWh5?=
 =?iso-2022-jp?B?OFFISitIMXhlejFKL0t0T2VKVTZGVU1BN0laVE12clVZcHJtNUkvK1BX?=
 =?iso-2022-jp?B?L2ExWDRPMWFtdDl0TkkzU0QvdWVRMElya1FnYW9MZHBYejh6aXFVYUMr?=
 =?iso-2022-jp?B?VWZMVEJzd09MS0pDTURzd2Vycm9oTXYwNWo3dEcwWitGN2JUdEVlMG1P?=
 =?iso-2022-jp?B?eUd0NFRQTW5iNENrQ01YQktmV0loRFJOZ0JVVXYwcUpiT216MWtVeWpt?=
 =?iso-2022-jp?B?M0ZNby9O?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520f3a3a-991d-4459-bf9d-08de8495484c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 02:23:03.0970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HinD94uY7hjLnV2P07yVDIAddYqwaj7MCvfsHSUjQpDuRiBzOgXZYgNvBPz66HBsV72bmkcLwqiiGFUEVXvb3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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

Series is:
Reviewed-by=1B$B!'=1B(BJesse Zhang <jesse.zhang@amd.com>

Should we enable this feature for SDMA?

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, February 19, 2026 3:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 6/6] drm/amdgpu/gfx12: align mqd settings with KFD
>
> Make sure to set the quantum bits in the compute MQD for better fairness =
across
> queues of the same priority.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index c902e20960b02..c8c9ebe127654 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3279,6 +3279,11 @@ static int gfx_v12_0_compute_mqd_init(struct
> amdgpu_device *adev, void *m,
>       mqd->cp_hqd_pipe_priority =3D prop->hqd_pipe_priority;
>       mqd->cp_hqd_queue_priority =3D prop->hqd_queue_priority;
>
> +     tmp =3D REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
> +     tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE,
> 1);
> +     tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM,
> QUANTUM_DURATION, 1);
> +     mqd->cp_hqd_quantum =3D tmp;
> +
>       mqd->cp_hqd_active =3D prop->hqd_active;
>
>       /* set UQ fenceaddress */
> --
> 2.53.0

