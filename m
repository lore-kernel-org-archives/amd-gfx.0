Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86771C3ABBC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 04:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E909510E113;
	Fri,  9 May 2025 04:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sAqqoKhc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEA910E113
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 04:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWnO7qCQaLOhYfd2WudCCWVzxoIwgdvMXhj6yzwEi+wHJscl87BKgR7QBaGPkOLjp7uU1USgU5TmtyRPHNLW6LmSJbU2zw23ypkhKFm8OFkC6lyf+PZRcDZEgs55ehxMAyuQlZDHQeioF7p0yIQ3jLJURnhw+0V0vWc4CqqDXYJl+OatbLhupsCVp1SHbovG1jm3HUxeT7ATVrvDTRycRH2Cpq8GR3ekFlRZQpggU9poQ7PbwyxIoTMA+ShNrtGRFu2QN3ahFwgxkkneTZTMXH60OcnoSeU/bhsQQyAsEQfQVA90wTIbylfHnJ8staLt1lAcsGz/SD1KUvznpH1meA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFFUaHSonDM1QCb1Ixg7nf2wE2NKzVbxyp4xPC/1q14=;
 b=bLb5LYHY+vw6WersI1ikXRiqFBBFUeSu4OKji/yIhcXyUX6Y5j5pfAXUPwaaqBAFjmAZg/SWxEqECY/zw/fHMknU1nfxdZyocM6e8Xde5t3WlzKv98+pRfIPUMA9k8Tg0hy8D5Wn5UddoXf5DUQ9LiIvRutzfHTBIKEcxT2Y1QCcMHLOpKU5zQS4Srp7DoWKVnJeY74o0PGmF9cfetsG6KcY/PmhWGYVV+0EUzkxWbkP51NU5DqDIm3JAFRTHmro1cm8qmzBSPECRwdK2ir7kn+sBO7Z230RvO7J0miwfc/1q4bH1UNaaRE+7AVbV0FlQahhUT+KPzKGqt5kkc8n4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFFUaHSonDM1QCb1Ixg7nf2wE2NKzVbxyp4xPC/1q14=;
 b=sAqqoKhcgF5h1R3xuNEAMzg/UZvGQsUmdGVpklEwWjK7TD27wKGjBP3HKZ0EGoEBpjH3Vu6LWBCK5iWBoe7FlWLWhXmx9vgRPrg37+atdRDlpHRWphLKv5xBLJeJ7BuQ2tvSKTRgkG9KmEAJ4JdSkM6E1doTikA8hb9WKJ1/+cc=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Fri, 9 May 2025 04:22:14 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 04:22:14 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: Re: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
Thread-Topic: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
Thread-Index: AQHbv9d4XpAdzZw0iECS+FEC5WeubLPIYiSAgAAtzgCAAaoYgA==
Date: Fri, 9 May 2025 04:22:00 +0000
Message-ID: <38c462f9-d181-4663-8f01-efd9d5b08060@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
 <20250508050926.228674-2-guoqing.zhang@amd.com>
 <1aca1130-082e-40df-83fd-eb00fa3ac206@amd.com>
 <fa7a29a3-7b02-4eb9-97d6-b1e1a07117fa@amd.com>
In-Reply-To: <fa7a29a3-7b02-4eb9-97d6-b1e1a07117fa@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DM4PR12MB5937.namprd12.prod.outlook.com
 (15.20.8722.017)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|PH0PR12MB7932:EE_
x-ms-office365-filtering-correlation-id: c3bac624-55b1-4646-43ac-08dd8eb1134a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ay/BHDhljIswdbHNcwgvq0hE22SGaxctm1IYwJftAHPs/hNlt3TX/3Sckd?=
 =?iso-8859-1?Q?yzgVETdUGaumzmA2+00GNwvV4MKuCPK5kaAacUNKcC/ggtt0tGyIQWiwXh?=
 =?iso-8859-1?Q?da/JbBffygGkBJlqv0ftEalF6rAYuicV8LkAi6Jk8zVSf8z4dk7C1AtGIq?=
 =?iso-8859-1?Q?TcXAxRgPbiCrnvymJcMEd9P+hgUo9rpQHhGbNkqAc/W64cnQM9lk13Kmtw?=
 =?iso-8859-1?Q?ZttgG+/cKoTsKkb7FhBjcl1QeWbg8LG9hW+U46b6bcIXQKvGpeHcKHP6xb?=
 =?iso-8859-1?Q?RHEuixAzX5OXYzRVBTdcQDONMGHFDJAaLougF4v9pyykF01k2s4VhS6+oU?=
 =?iso-8859-1?Q?TuIxN21iZK36HT0GagPAFbV49IlWOUlYbIlnGyBclBSpoOUeDi8jtN/Dn7?=
 =?iso-8859-1?Q?Dlv4AVhBKvLp7wgOCmv1bgKB0/4dxBMQPiRL7uFWNQqJz9L9t788WmO9zz?=
 =?iso-8859-1?Q?4GQmqsRukBWAW+GypQ470najylZpQwH79WOQqVzOTxVULpvvKlBVQUyiOP?=
 =?iso-8859-1?Q?03aI2Gu86RmnDw1qO1SlWmm86Fy77yU4kItEck7KN+rQTGzm8RTxMAAv1d?=
 =?iso-8859-1?Q?YJfXV/pGCz5Lho6N7WsudnifL/ONPZrNBPuHulh2kab2OMXX4slerymbUJ?=
 =?iso-8859-1?Q?NUUhr2aw3BcxnFZLGmGMuQa6SsXqTOhGDHlS95+oViWRnTo1Im5CptTuOo?=
 =?iso-8859-1?Q?WDFH/e7dW1Ot7uSN8gaoE6ajIHK6HIbMYEdqzkJngLx4NdwooQmwZCRlBu?=
 =?iso-8859-1?Q?GrUv7Ia9SYbGvaqwZIW8xKX93vzY2T4JYllz/KR6fBc6cRz+XfqiDYPTMW?=
 =?iso-8859-1?Q?xOO2tEPuIjamXJcg2TRRSLoU/ckDyP0YaGCpm97+X5CZEkx0I32UWcaqQo?=
 =?iso-8859-1?Q?KFUpEti74gR5wtaFVFzPokwgoFBkN6i8RMZ01p4qFQeabviW9eR+fUHhY7?=
 =?iso-8859-1?Q?auxpUYi3ykARaKvd/fCSVcP2uHDE/b5Eu14m8TTJKGJijOT9SDBAN5vqVU?=
 =?iso-8859-1?Q?K2NlnlMghfjDCouf6RJbo+pkJbS9zp9aelnIwSFEY7/tZRKTDFn4w880vX?=
 =?iso-8859-1?Q?a1nkYA+dSHH7w80PNuyDSscgQszTPNG9DsJC1oOgVyi0LYkjaXi+VV51GU?=
 =?iso-8859-1?Q?z6kTu3MXQC2ojb0Gi0sAK8bwgwj9h8U7KPi74M+JstIXysPJll9NKGfLoY?=
 =?iso-8859-1?Q?NldgIeePLjkqf4Q4mctozFS6gfkPfSJp6GwcL5CQAgyIOIMotUSLCWSSwf?=
 =?iso-8859-1?Q?sfQue9fWYnrPlvzEpQzEfxw6IjrZ2KGkam8MS+7ezKGACTIfaEyRdUg9/3?=
 =?iso-8859-1?Q?oKD6e6Y/9yiydOl3EOoEuYiZnhHViKYA+TvpFanpnTcp+cU68UwOlpkn5J?=
 =?iso-8859-1?Q?U74q84gtwlXab53ALT8hfN3onrX6320b0kkTru4pav2kPP407BIcouoFQf?=
 =?iso-8859-1?Q?89LLBdIuWPtSi9BGK400B+slBbn1Z+VY2M7WnBBCuOG+co5pl46JJ0Jimt?=
 =?iso-8859-1?Q?Q0ZCYPgIFbZ7f/30ukHd/asw5MJxVdGTdfJGBDsBDGX/QaV/D1Wf8pK8Nf?=
 =?iso-8859-1?Q?yHnw7Rk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lNxz1z/3Oit6FcyEZzHj9MyFNlOXWezvTz4ZJmXZZYMRrWchfnSla1wjuX?=
 =?iso-8859-1?Q?buqF4SurhsJ8A0NGwH52j+RDJY1NErVatysufHmXWum3YnNw6USCHyTiAD?=
 =?iso-8859-1?Q?lluYTUEvBd6xvPLe1SCVF72Loix1vOxNSTUg28NzOkJvWJFXqcOHLv6bRt?=
 =?iso-8859-1?Q?36WwWpMg3zzs0ETE7DV3+P4TB3VtwCSP9bgU8ANxZ9iEkc5aMBvUEmxzJR?=
 =?iso-8859-1?Q?lDCoNRmBq0OSi1bNQrODMVdFqytbsa0SBo79+8F/L0ZFSaKZSUglEtuDbj?=
 =?iso-8859-1?Q?yHazlcyAgZf5mZxK0fgN+d2jsi3BkCaTjR9lnZBMbauiaA+u8N6WUTQWzn?=
 =?iso-8859-1?Q?me44HqsaHaXnc2ROzc3HZ3hTku3SwYOQ9tBbeD/LD3o06BOmGg/iuQUEI6?=
 =?iso-8859-1?Q?L9xRUR/f71xu/qDoXuPennObC3XSXFpvc5lp76O2et/lqeTHm070OJaq7A?=
 =?iso-8859-1?Q?XaMEJDjqsLOw5E5BYztx8AFLsavuB7C55gldPgE4JPrPlBrm/VDV9/J2fN?=
 =?iso-8859-1?Q?rfJwe15nofpY1n+jzSsRazz9VaswT2pDEArUrd9bdZ5B4R5m8bS95asgBX?=
 =?iso-8859-1?Q?HtqoXVPmVGjH3o+cyEV38N+Okn1m3L08nv0soJukW2CSp0O8CS4s2u/qfO?=
 =?iso-8859-1?Q?/wXX6Z6Ty8ZQ4g7s20eXdRDCkEpYtZXwZi8Cgfst6Vz4ChT348DvOT2UGo?=
 =?iso-8859-1?Q?AVxqB7W/EQYLj8Y9W6E6e08RbRrNafm2M2E2ilPQaQotg55opHv+MokDjU?=
 =?iso-8859-1?Q?AcaTB44zXgxQ/ASSVYV/i0/ybH9vgK2HF5xU3b8c1s2+Fsv+j7R7pO/mVm?=
 =?iso-8859-1?Q?k+yHqx3zAqaYdnYU1ah6NNKlVI9xdLVC0lWAy3Em+cSnliTXH8W5VU9lxX?=
 =?iso-8859-1?Q?LRcCGIi0RoD4Vq+RzAms8UVnXRrO97m9IzN2DWdsTGvqZ/7TQXjQYSNFmT?=
 =?iso-8859-1?Q?DzIfR8Pl5+638PCeHfN6uXn+vpb1X3WFLZhrktCfaP6go0eMFMkQ/eosYa?=
 =?iso-8859-1?Q?Mo5WiIH/+ZNxzvJey2NQfT5vxbg0PRcLEjRYJRv5joEMTaaI6UHIkEq+5E?=
 =?iso-8859-1?Q?pSpIdkbtNmYieRNbozedGrayTY6o7FUgZOMjtcTPPPW4tjOn2li+xlZmGE?=
 =?iso-8859-1?Q?SFh0+potcqbwe1S+DRlG1762CGPcQHGjQLRVMaUTK3YffgOtz6xceoiKq9?=
 =?iso-8859-1?Q?B2w4kCQw9FzGsBQHp23CfypgedgOFkLrpVpMdZSusBdm9RdHimAl4R2dIx?=
 =?iso-8859-1?Q?KG7jC2hebGN+i4OfzvaFe25CQ7BddSyqZ5p99LsAwK/ZOgdGxPvHQL+0vg?=
 =?iso-8859-1?Q?CfOgcHWnAdQcQY+edM6m2coPsN4H3o4OifafOdLjAwF6wCkug1AYvQIneB?=
 =?iso-8859-1?Q?aYlJvzbnwsl/TW5DnEFervIYyEfds0Y9jPQJJP1pGKRU2LWFbf5cKrFqoK?=
 =?iso-8859-1?Q?OsZaPNasQLWQ5ZK6p9xs1uH6grWpZZroAhneEdETjYFkHrY00a+gw1TrtJ?=
 =?iso-8859-1?Q?bBZMqB/dGHmLKAijv97DzET7UrE2ebX6cOb/bkHylvjBGwiP3+XW4KRdUn?=
 =?iso-8859-1?Q?mkczvx3EyQ+IR5kTzzGTDyeRHCDvUX0515ihfif+GAfLwQ054ZMATT9i6F?=
 =?iso-8859-1?Q?M1hjO+Tt3BaJs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_38c462f9d18146638f01efd9d5b08060amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bac624-55b1-4646-43ac-08dd8eb1134a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 04:22:14.0309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Q32c7TrvGgaTfwnDR8mlk3RcLozzol82vLlko8fLxXmkrc+9VPQMQc6a48kUXpZzlUmXA1yKvri/M/elAXC7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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

--_000_38c462f9d18146638f01efd9d5b08060amdcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On 2025/5/8 18:56, Christian K=F6nig wrote:
> On 5/8/25 10:12, Lazar, Lijo wrote:
>>
>> On 5/8/2025 10:39 AM, Samuel Zhang wrote:
>>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>>> is enabled, XGMI physical node ids may change when waking up from
>>> hiberation with different vGPU devices. So update XGMI info on resume.
>>>
>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 +++++++++++++++++++++=
+
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  4 ++++
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 ++++++
>>>   3 files changed, 34 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
>>> index d477a901af84..843a3b0a9a07 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
>>>              r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
>>>              if (r)
>>>                      return r;
>>> +           adev->gmc.xgmi.prev_physical_node_id =3D adev->gmc.xgmi.phy=
sical_node_id;
>>>      }
>>>
>>>      /* enable PCIE atomic ops */
>>> @@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_device *dev=
, bool notify_clients)
>>>      return 0;
>>>   }
>>>
>>> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
>>> +{
>>> +   int r;
>>> +
>>> +   /* Get xgmi info again for sriov to detect device changes */
>>> +   if (amdgpu_sriov_vf(adev) &&
>>> +       !(adev->flags & AMD_IS_APU) &&
>>> +       adev->gmc.xgmi.supported &&
>>> +       !adev->gmc.xgmi.connected_to_cpu) {
>>> +           adev->gmc.xgmi.prev_physical_node_id =3D adev->gmc.xgmi.phy=
sical_node_id;
>>> +           r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
>>> +           if (r)
>>> +                   return r;
>>> +
>>> +           dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>>> +                   adev->gmc.xgmi.prev_physical_node_id, adev->gmc.xgm=
i.physical_node_id);
>>> +   }
>>> +   return 0;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_device_resume - initiate device resume
>>>    *
>>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, =
bool notify_clients)
>>>              r =3D amdgpu_virt_request_full_gpu(adev, true);
>>>              if (r)
>>>                      return r;
>>> +           r =3D amdgpu_device_update_xgmi_info(adev);
>>> +           if (r)
>>> +                   return r;
>>>      }
>>>
>>>      if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_xgmi.h
>>> index 32dabba4062f..1387901576f1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>>> @@ -89,6 +89,7 @@ struct amdgpu_xgmi {
>>>      u64 node_segment_size;
>>>      /* physical node (0-3) */
>>>      unsigned physical_node_id;
>>> +   unsigned prev_physical_node_id;
>>>      /* number of nodes (0-4) */
>>>      unsigned num_physical_nodes;
>>>      /* gpu list in the same hive */
>>> @@ -101,6 +102,9 @@ struct amdgpu_xgmi {
>>>      uint8_t max_width;
>>>   };
>>>
>>> +#define amdgpu_xmgi_is_node_changed(adev) \
>> Typo - xgmi
>>
>>> +   (adev->gmc.xgmi.prev_physical_node_id !=3D adev->gmc.xgmi.physical_=
node_id)
>> Since prev_physical_node_id is updated only for VF, the check should be
>> there here as well.
>>
>> Otherwise, you may have something like below in
>> amdgpu_device_update_xgmi_info()
>>
>> amdgpu_xgmi.node_changed =3D false;
>> if (check_condition) {
>>       prev_node =3D adev->gmc.xgmi.physical_node_id;
>>       adev->gfxhub.funcs->get_xgmi_info(adev)
>>       amdgpu_xgmi.node_changed =3D (prev_node !=3D adev->gmc.xgmi.physic=
al_node_id);
>> }
>>
>> To make it clearer -
>>
>> Would still prefer to wrap under amdgpu_virt_migration_xyz() to make it
>> clear that this is done for node migration.
>
> Yeah, that is a rather good idea as well.
>
> And we should *always* execute that and not just when the physical node i=
d changes.
>
> Otherwise we won't always test the code path and potentially break it at =
some point.


Hi @Koenig, Christian <mailto:Christian.Koenig@amd.com>, thank you for
the explanation.

Hi @Lazar, Lijo <mailto:Lijo.Lazar@amd.com>, are you OK with removing
the check? I can do reset test using quark in VM to ensure no regression
is introduced. Please comment if you still have different opinion. Thank
you!

Regards
Sam


> Regards,
> Christian.
>
>> Ex:
>>
>> bool amdgpu_virt_migration_detected()
>> {
>>       return amdgpu_xgmi.node_changed; // And any other combination chec=
ks
>> which could up in future.
>> }
>>
>> The check needs to be done for any further changes down the series like
>>
>> if (amdgpu_virt_migration_detected())
>>       psp_update_gpu_addresses();
>>
>> Thanks,
>> Lijo
>>
>>> +
>>>   struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *a=
dev);
>>>   void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
>>>   int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct=
 amdgpu_device *adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v9_0.c
>>> index 59385da80185..7c0ca2721eb3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip_bloc=
k *ip_block)
>>>      struct amdgpu_device *adev =3D ip_block->adev;
>>>      int r;
>>>
>>> +   if (amdgpu_xmgi_is_node_changed(adev)) {
>>> +           adev->vm_manager.vram_base_offset =3D adev->gfxhub.funcs->g=
et_mc_fb_offset(adev);
>>> +           adev->vm_manager.vram_base_offset +=3D
>>> +                   adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.no=
de_segment_size;
>>> +   }
>>> +
>>>      /* If a reset is done for NPS mode switch, read the memory range
>>>       * information again.
>>>       */

--_000_38c462f9d18146638f01efd9d5b08060amdcom_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <7926701A0147DC4DAEB29FE711776361@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<div>
<p class=3D"MsoNormal"><br>
On 2025/5/8 18:56, Christian K=F6nig wrote:<br>
&gt; On 5/8/25 10:12, Lazar, Lijo wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 5/8/2025 10:39 AM, Samuel Zhang wrote:<br>
&gt;&gt;&gt; For virtual machine with vGPUs in SRIOV single device mode and=
 XGMI<br>
&gt;&gt;&gt; is enabled, XGMI physical node ids may change when waking up f=
rom<br>
&gt;&gt;&gt; hiberation with different vGPU devices. So update XGMI info on=
 resume.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Jiang Liu &lt;gerry@linux.alibaba.com&gt;<br>
&gt;&gt;&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++=
++++++++++++++++++++<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbs=
p; |&nbsp; 4 ++++<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 6 ++++++<br>
&gt;&gt;&gt;&nbsp;&nbsp; 3 files changed, 34 insertions(+)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; index d477a901af84..843a3b0a9a07 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt; @@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_dev=
ice *adev,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
adev-&gt;gmc.xgmi.prev_physical_node_id =3D adev-&gt;gmc.xgmi.physical_node=
_id;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable PCIE atomic ops */<br>
&gt;&gt;&gt; @@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_de=
vice *dev, bool notify_clients)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt; +static int amdgpu_device_update_xgmi_info(struct amdgpu_devic=
e *adev)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +&nbsp;&nbsp; /* Get xgmi info again for sriov to detect devic=
e changes */<br>
&gt;&gt;&gt; +&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;flags &amp; A=
MD_IS_APU) &amp;&amp;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.suppor=
ted &amp;&amp;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gmc.xgmi.conne=
cted_to_cpu) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
adev-&gt;gmc.xgmi.prev_physical_node_id =3D adev-&gt;gmc.xgmi.physical_node=
_id;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (r)<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_info(adev-&gt;dev, &quot;xgmi node, old id %d, new id %d\n&quot;,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.prev_phys=
ical_node_id, adev-&gt;gmc.xgmi.physical_node_id);<br>
&gt;&gt;&gt; +&nbsp;&nbsp; }<br>
&gt;&gt;&gt; +&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; * amdgpu_device_resume - initiate device res=
ume<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt;&gt; @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_devi=
ce *dev, bool notify_clients)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
r =3D amdgpu_device_update_xgmi_info(adev);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (r)<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;switch_power_state =
=3D=3D DRM_SWITCH_POWER_OFF)<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt;&gt;&gt; index 32dabba4062f..1387901576f1 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt;&gt;&gt; @@ -89,6 +89,7 @@ struct amdgpu_xgmi {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 node_segment_size;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* physical node (0-3) */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned physical_node_id;<br>
&gt;&gt;&gt; +&nbsp;&nbsp; unsigned prev_physical_node_id;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of nodes (0-4) */<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned num_physical_nodes;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gpu list in the same hive */<=
br>
&gt;&gt;&gt; @@ -101,6 +102,9 @@ struct amdgpu_xgmi {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t max_width;<br>
&gt;&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt; +#define amdgpu_xmgi_is_node_changed(adev) \<br>
&gt;&gt; Typo - xgmi<br>
&gt;&gt;<br>
&gt;&gt;&gt; +&nbsp;&nbsp; (adev-&gt;gmc.xgmi.prev_physical_node_id !=3D ad=
ev-&gt;gmc.xgmi.physical_node_id)<br>
&gt;&gt; Since prev_physical_node_id is updated only for VF, the check shou=
ld be<br>
&gt;&gt; there here as well.<br>
&gt;&gt;<br>
&gt;&gt; Otherwise, you may have something like below in<br>
&gt;&gt; amdgpu_device_update_xgmi_info()<br>
&gt;&gt;<br>
&gt;&gt; amdgpu_xgmi.node_changed =3D false;<br>
&gt;&gt; if (check_condition) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev_node =3D adev-&gt;gmc.xgm=
i.physical_node_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfxhub.funcs-&gt;get_=
xgmi_info(adev)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi.node_changed =3D (=
prev_node !=3D adev-&gt;gmc.xgmi.physical_node_id);<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; To make it clearer -<br>
&gt;&gt;<br>
&gt;&gt; Would still prefer to wrap under amdgpu_virt_migration_xyz() to ma=
ke it<br>
&gt;&gt; clear that this is done for node migration.<br>
&gt;<br>
&gt; Yeah, that is a rather good idea as well.<br>
&gt;<br>
&gt; And we should *always* execute that and not just when the physical nod=
e id changes.<br>
&gt;<br>
&gt; Otherwise we won't always test the code path and potentially break it =
at some point.<br>
<br>
<br>
Hi @Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com">mailt=
o:Christian.Koenig@amd.com</a>&gt;, thank you for
<br>
the explanation.<br>
<br>
Hi @Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">mailto:Lijo.Lazar=
@amd.com</a>&gt;, are you OK with removing
<br>
the check? I can do reset test using quark in VM to ensure no regression <b=
r>
is introduced. Please comment if you still have different opinion. Thank <b=
r>
you!<br>
<br>
Regards<br>
Sam<br>
<br>
<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt;&gt; Ex:<br>
&gt;&gt;<br>
&gt;&gt; bool amdgpu_virt_migration_detected()<br>
&gt;&gt; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_xgmi.node_change=
d; // And any other combination checks<br>
&gt;&gt; which could up in future.<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; The check needs to be done for any further changes down the series=
 like<br>
&gt;&gt;<br>
&gt;&gt; if (amdgpu_virt_migration_detected())<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_update_gpu_addresses();<br=
>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Lijo<br>
&gt;&gt;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&nbsp;&nbsp; struct amdgpu_hive_info *amdgpu_get_xgmi_hive(stru=
ct amdgpu_device *adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp; void amdgpu_put_xgmi_hive(struct amdgpu_hive_info =
*hive);<br>
&gt;&gt;&gt;&nbsp;&nbsp; int amdgpu_xgmi_update_topology(struct amdgpu_hive=
_info *hive, struct amdgpu_device *adev);<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/g=
pu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt;&gt; index 59385da80185..7c0ca2721eb3 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt;&gt; @@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgp=
u_ip_block *ip_block)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D i=
p_block-&gt;adev;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt; +&nbsp;&nbsp; if (amdgpu_xmgi_is_node_changed(adev)) {<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
adev-&gt;vm_manager.vram_base_offset =3D adev-&gt;gfxhub.funcs-&gt;get_mc_f=
b_offset(adev);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
adev-&gt;vm_manager.vram_base_offset +=3D<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physical_=
node_id * adev-&gt;gmc.xgmi.node_segment_size;<br>
&gt;&gt;&gt; +&nbsp;&nbsp; }<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If a reset is done for NPS mo=
de switch, read the memory range<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * information again.<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_38c462f9d18146638f01efd9d5b08060amdcom_--
