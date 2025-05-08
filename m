Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF92C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 10:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481EA10E8D0;
	Thu,  8 May 2025 10:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1IAOcnGX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4567910E8CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 10:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJeFq5+RhNQ+4uR+2p7MlehmFhyb479kJeK3ywcq0vRAdetYL0cDdNgv4J0XrTSNLwpzhg0/XYbbiWi7738gWkjspFPNRcqzoNDoTP9sG5JxAWDHqyWDdWrVbfpma/gP2jJeaANvsswGxOsIJ8nB7nis122XDkXL1GKMd3Qh3IvMQF01fBfUENocJt61BXn9mCoVsLfYIfRjtuvypeLv+kSfjUUZ8QxDi0JcZJT2G832c0iTQcONBxsLvmecnVSX8S+vsKHNYO3MjP5bym+fZAYbC7zl2Z1tv0fUsCVjSlm+bBq7DFzxNcYIRRXNHTQsag+HkGW47xk5kVsAwH+v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArU+a15QHgdBcJxL3KjHEaTNvSjSMh/3nesidUnuGe8=;
 b=QB2opxav9LN/gBeQ09bGLSO//WZB1LJ/FwjEeNtn9dGwbaJ9w0+XhKQz7SxcQtDsalCQxnOEJ5/lcyxI/kKGvSznkHa1SCRauTX/KmvHZqcB3bC6B+eq3CWvfymZl4K6wkc2i4vFXUjDntIpY+uoXs8bqLhVc1VCAYC5bavetKhSMAvN5d2MM1EQrY6D0mkLQn62rch21TyhPCEu7VKWWxu3Lqjg3vc98vknMO32mu8RCo69eqckZfLBHc1JY68LAOehlMoWuV886SwVRsIhqmTdqN9JG4DDSpvMeRX8zBygcWykDnNcwe8XI7FHcPS09sSSLIHmi7niG7eAJo1F2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArU+a15QHgdBcJxL3KjHEaTNvSjSMh/3nesidUnuGe8=;
 b=1IAOcnGXzjtJR7b5P1HHZmY5aJSbwUChoWyyxXclqIxsoeZBBYRCYq/+1rq+iNMYsvHxgdhgHlx8N/7Zda6ofcVr6+r2YEZm/E3R9H/rTnWZubPHbMXi3xV3Gf7oNH9NVEYseuQeIYOaSMrc57e1AZaOuU8fIoOmXyqFqH3JqDw=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Thu, 8 May 2025 10:03:43 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 10:03:43 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, GuoQing (Sam)"
 <GuoQing.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: Re: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
Thread-Topic: [PATCH v4 1/7] drm/amdgpu: update XGMI info on resume
Thread-Index: AQHbv9d4XpAdzZw0iECS+FEC5WeubLPIdyoAgACNXIA=
Date: Thu, 8 May 2025 10:03:36 +0000
Message-ID: <73cd6a4c-e370-4d1a-b5ae-4bb31293eca8@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
 <20250508050926.228674-2-guoqing.zhang@amd.com>
 <b0ada9c6-c31f-455e-a24f-4106b62647f1@amd.com>
In-Reply-To: <b0ada9c6-c31f-455e-a24f-4106b62647f1@amd.com>
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
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|CYXPR12MB9386:EE_
x-ms-office365-filtering-correlation-id: c8a68fa7-e0a9-43e3-d6f1-08dd8e179d74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rGgcpMKBPC0qHF1bZ7EM18E7bylW/wvPdjHcQ9TjaT3zFk/iAr//XHhx+i?=
 =?iso-8859-1?Q?91BBDl2J9+jn4WBM0tXu6j+A1H5MHW4PZMJ6XjqlQ98/r4loKDfPz0lBMm?=
 =?iso-8859-1?Q?oHdbYdOyWASEFB+P2/lsldAuCGgoa3p3aZB0Y6oU3f++jnck+DbPPElmgW?=
 =?iso-8859-1?Q?QFh3H0VJc+CsP62MBZ+hLlTvt4owuKEUcKq4fnCgfxOh4eR+Q11BY2G6TY?=
 =?iso-8859-1?Q?xxzP00MLwbE9Wgd5L3aFvcyTLpfHWg275jkGpcSRf2wjpa6vez7Xubffd/?=
 =?iso-8859-1?Q?GP0xzjJvhAzPQJtMJRnZ+pqpEqyGXz+HUHCWS6J/Ubl2CdV2/QV+fqj7Cx?=
 =?iso-8859-1?Q?CcONWW77H142dfWCHgKVKZpni0H3BNf81/QgZqnV1fPD/i0FvFyzOsd+Pr?=
 =?iso-8859-1?Q?OSNE/SITjndPlnIS4VUzDAZGuVWETjkzxG/9l51nz1+ROgtUeoIEpI+zh8?=
 =?iso-8859-1?Q?xs67sbfV5GfVseFxMl7wwg539he/ie8KhV0K+O6baulmT2eMX2HHryxCBi?=
 =?iso-8859-1?Q?jcUN6+f96vKhyTtACOCgghX/1MsYj6l41ipYDfHA3Ej9oBMHl4kWgKuAek?=
 =?iso-8859-1?Q?J3UmJ/vhv3n4c1mCUsY94Ai+QqbtceS/hUwSX0AeWMZKVWnHx5m5PZ1Xmm?=
 =?iso-8859-1?Q?bZI04MkzINNajDUa0EScb2hKmvfAyEGnTwt2RZzG9HJokXrpWVFp6d+oUa?=
 =?iso-8859-1?Q?7bqDQ/p8Lpd/z9RH6LdLRCWCAA4ggBkIjBZnOBqXcl5wWQr+SuwO36ksT1?=
 =?iso-8859-1?Q?hWJqzHAh9S3aoP1dBtXYJA3fnfMAQVz0UUW+tc0yV7qxKN5EohPHwL9etm?=
 =?iso-8859-1?Q?NqEsM0ZMIE4GrMU+IgHX92MrpYYzVe4uC6exmgYP3uf7DwDZXtc9CMxNM8?=
 =?iso-8859-1?Q?0e5Vf75o/kJBY9FA/QpPuJPXPfl2J+oGp6AorS7sZEH4F6vK+bN6s44B8C?=
 =?iso-8859-1?Q?skT0pZ1FfdhedRAO7RtjnY0lq07Q8r6mvjPIIxXUkvRXVlg91vDa3tj20p?=
 =?iso-8859-1?Q?ro0Il01zT0zCglBK6rtbJeBgnCZpvWLq4kztmsWra+BEO7AXpTb0N4cIMO?=
 =?iso-8859-1?Q?ztleush0INjS+lyqnYf0Kl33lrbED8aeeIvoJn7XSfJPqbpRps1fDlEnvW?=
 =?iso-8859-1?Q?hGaNDyP9YhDKJ3tNO6heMtNcKQ0fxZNQFFMSp9FSY/HwY3H4FdKSG2FHsO?=
 =?iso-8859-1?Q?nIjswZJ6jmHdmh+BHLF1PpcPF0rOiW6LwOAEZDCAB1PflwN9vVC41n0I4j?=
 =?iso-8859-1?Q?ByD35CD7LIPFFSiQsNjNMog3kGNagLX+yms/v3pRLd/4se0nuGw0KqGBrn?=
 =?iso-8859-1?Q?OzVHHxTC23WCIOTJQHRiQK15m9JLYKTKGcAw5mMAOtpmlHA9gaMGfNtK/L?=
 =?iso-8859-1?Q?gK3ocFywl+g1U8cFeveOCsCVAybnRwkQISObGb4jUhTIBQ1hcE7prW3jzR?=
 =?iso-8859-1?Q?hxOxfDQb4ubQE71E+gSv7lc8mukQrYaxsYGTEYxSo93DYLBZn7SIE4C5XP?=
 =?iso-8859-1?Q?qAR1hyzXafggGMW+aUexJlIDCDZ7xCHksZuh5I1rjAxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0SqdfqkHdX3yYWgB+EYCqAdAQDBBKJNTQlw0yAxhIvKUc9eE4Zx3Ge+Rj6?=
 =?iso-8859-1?Q?KFablFWXQac7/Ae4OnBt9hBSIXh4gj6NgOmbEQMf2P+DczgZKdXQ85xJrA?=
 =?iso-8859-1?Q?uYlOUOuPb9rw1I8D4De/NJfj5fRAAlS//FRnxaEUm5je4GTBS5EIxJMnsw?=
 =?iso-8859-1?Q?ifJUP1TS75hQ1xoDx5Sw86BKBw1fYUXKyRBW+SEQjiyD45a+eRBTXlmPmB?=
 =?iso-8859-1?Q?luIy1ymCM5S85ZtAtOClInWnanqWmPxg9MFK2ajX0dPq17ZIlQJIO2nxIC?=
 =?iso-8859-1?Q?dvzFh4vqSlI+bvHcEPPfS7a6OpS0qCKe5wfQOlwBrvyHNspl0ZnIzJh4gv?=
 =?iso-8859-1?Q?uQsy4x2W5A9I4gAj9MRo1/riWt8Jncj+95cSKNnOe55ff0jFfwxd9d7VpF?=
 =?iso-8859-1?Q?KyzJdW5M3uH8K3awTr/vSoEVGk1dPrX4d2h3nsVWF6HZY2BrgMVg2ULPvH?=
 =?iso-8859-1?Q?19sCWWjHRiZug7mN97A40VDkiRBzFELBvomkWfP5bbkxwRq1/gOAXCRIqr?=
 =?iso-8859-1?Q?I+omuZZu8C/SO7vgvSCWI/SS/Y0hgL/vxnMDq6eHxiFj2HCIrBMC2wEW5T?=
 =?iso-8859-1?Q?82TpVBuGvlLID7hDDOVAvN5eT8QJBhfF5DGRLzbClKE4+YmIB1P9ZLUTBC?=
 =?iso-8859-1?Q?z5F1YI/cSgWB9X8CCO/f8AGEVLj8R1V36ARX8jMBdxA21lLjl7ASXveD8f?=
 =?iso-8859-1?Q?RJaevXtEQ+OXPiKp2Xfq806h2QUdrCn08cCb8HXcMEfIZrSTf1hHh7+3Fe?=
 =?iso-8859-1?Q?tkfhC55WjTNGqTvpWncKkHAY8ZghKrgf8//KxtH6qq4CNzmrfG5TgF+Qqi?=
 =?iso-8859-1?Q?yAMxyrdVDX6mFQD+ndjGiSz4c6yqX2d4uITJCDSEDgOAOIKhBeMSs2/OFG?=
 =?iso-8859-1?Q?rFBiDk9gRWg9LuqK5erS7ejm5IBZIknSX4Kl+KbKynWaAeLeupcVi2HLaj?=
 =?iso-8859-1?Q?i054Xt/G9hMEVaKzzqHjGuxtOoPTqqGFi+gZOIW6YT5rYc5FILqla9/VDl?=
 =?iso-8859-1?Q?lTpaZPPgOrHsWULCXwTnOIcFQDhZTcEKK1j9ro/1c0/DO2xa76fBGsvZ94?=
 =?iso-8859-1?Q?kWpjk2O4Vz0ATGUslToUDHsxdquUoeBlnpdOzxwU8oj8QPk2GYQ+FiTika?=
 =?iso-8859-1?Q?vvyTBjeuDhcWNzEOObM2CH4Y4sROYdI6GtlpRkf9v2y93AtNQWUnsAQVJn?=
 =?iso-8859-1?Q?389+iz1MoaZKixr3KHsDnmvlxnYXsi+RBdcgB3o6jxmeXVF/7a+jZxOQbD?=
 =?iso-8859-1?Q?2PJziIf3W8zpW15dmJDsnZ5G4M9Ju/x42tUM8PRSO/YXIJnup4j5Titq9N?=
 =?iso-8859-1?Q?1nVLjHoxzHZTmgrYP874wyAbw9XZAEUZesGmxASkt/tmeTVXFP72YNbrhG?=
 =?iso-8859-1?Q?82h6+7SR6drtmZh7QcUTldbCSBqJ9sQABdfMKSOjl3L9wSYKaBbGDtUIJg?=
 =?iso-8859-1?Q?9zRxDiVdsQFJJ5HvLhS7LgOUJ29pTpbqIHKVOPyqKlHdruOZoxM/HUqSWI?=
 =?iso-8859-1?Q?hA9ay1JSf4beOm9yh43sfXLOBRFZrRVkrqxTO+PPnC+Tw/vpdcXsGCIo18?=
 =?iso-8859-1?Q?ubMztRkHh4GXWrtplHVDh9LQQQcEfvps6g7GR27Mp/C8j/rMUfxeBpt9t/?=
 =?iso-8859-1?Q?htrURbSFntkWLFXuVGvH9qZ7+TuiK8VOIe?=
Content-Type: multipart/alternative;
 boundary="_000_73cd6a4ce3704d1ab5ae4bb31293eca8amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a68fa7-e0a9-43e3-d6f1-08dd8e179d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 10:03:43.2920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3Yb56+umkKIUD4zboEjy1/W3NeG9M4NfpV4+00PXhPqKL/EWmrX5Irn6CVBUdA068jCHkyCqBD+WlHIrDZkMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386
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

--_000_73cd6a4ce3704d1ab5ae4bb31293eca8amdcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On 2025/5/8 17:27, Christian K=F6nig wrote:
>
> On 5/8/25 07:09, Samuel Zhang wrote:
>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>> is enabled, XGMI physical node ids may change when waking up from
>> hiberation with different vGPU devices. So update XGMI info on resume.
>>
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  4 ++++
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  6 ++++++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
>> index d477a901af84..843a3b0a9a07 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>               r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
>>               if (r)
>>                       return r;
>> +            adev->gmc.xgmi.prev_physical_node_id =3D adev->gmc.xgmi.phy=
sical_node_id;
>>       }
>>
>>       /* enable PCIE atomic ops */
>> @@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool notify_clients)
>>       return 0;
>>   }
>>
>> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
>> +{
>> +    int r;
>> +
>> +    /* Get xgmi info again for sriov to detect device changes */
>> +    if (amdgpu_sriov_vf(adev) &&
>> +        !(adev->flags & AMD_IS_APU) &&
>> +        adev->gmc.xgmi.supported &&
>> +        !adev->gmc.xgmi.connected_to_cpu) {
>> +            adev->gmc.xgmi.prev_physical_node_id =3D adev->gmc.xgmi.phy=
sical_node_id;
>> +            r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
>> +            if (r)
>> +                    return r;
>> +
>> +            dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>> +                    adev->gmc.xgmi.prev_physical_node_id, adev->gmc.xgm=
i.physical_node_id);
>> +    }
>> +    return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_device_resume - initiate device resume
>>    *
>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev, b=
ool notify_clients)
>>               r =3D amdgpu_virt_request_full_gpu(adev, true);
>>               if (r)
>>                       return r;
>> +            r =3D amdgpu_device_update_xgmi_info(adev);
>> +            if (r)
>> +                    return r;
>>       }
>>
>>       if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xgmi.h
>> index 32dabba4062f..1387901576f1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> @@ -89,6 +89,7 @@ struct amdgpu_xgmi {
>>       u64 node_segment_size;
>>       /* physical node (0-3) */
>>       unsigned physical_node_id;
>> +    unsigned prev_physical_node_id;
>>       /* number of nodes (0-4) */
>>       unsigned num_physical_nodes;
>>       /* gpu list in the same hive */
>> @@ -101,6 +102,9 @@ struct amdgpu_xgmi {
>>       uint8_t max_width;
>>   };
>>
>> +#define amdgpu_xmgi_is_node_changed(adev) \
>> +    (adev->gmc.xgmi.prev_physical_node_id !=3D adev->gmc.xgmi.physical_=
node_id)
>
> Please drop that function and the related checks.
>
> If this is necessary we want to update the relevant parameters all the ti=
me and not just when something changed.


Hi @Lazar, Lijo <mailto:Lijo.Lazar@amd.com> and @Koenig, Christian
<mailto:Christian.Koenig@amd.com>, you have different opinion on if the
check is needed. Could you align on this? Thank you!

Regards
Sam


>
> Regards,
> Christian.
>
>> +
>>   struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *ad=
ev);
>>   void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
>>   int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct =
amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v9_0.c
>> index 59385da80185..7c0ca2721eb3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block=
 *ip_block)
>>       struct amdgpu_device *adev =3D ip_block->adev;
>>       int r;
>>
>> +    if (amdgpu_xmgi_is_node_changed(adev)) {
>> +            adev->vm_manager.vram_base_offset =3D adev->gfxhub.funcs->g=
et_mc_fb_offset(adev);
>> +            adev->vm_manager.vram_base_offset +=3D
>> +                    adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.no=
de_segment_size;
>> +    }
>> +
>>       /* If a reset is done for NPS mode switch, read the memory range
>>        * information again.
>>        */

--_000_73cd6a4ce3704d1ab5ae4bb31293eca8amdcom_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <4D71D0F0CF1A6F428601ABB6DC51F9A2@amdcloud.onmicrosoft.com>
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
On 2025/5/8 17:27, Christian K=F6nig wrote:<br>
&gt;<br>
&gt; On 5/8/25 07:09, Samuel Zhang wrote:<br>
&gt;&gt; For virtual machine with vGPUs in SRIOV single device mode and XGM=
I<br>
&gt;&gt; is enabled, XGMI physical node ids may change when waking up from<=
br>
&gt;&gt; hiberation with different vGPU devices. So update XGMI info on res=
ume.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Jiang Liu &lt;gerry@linux.alibaba.com&gt;<br>
&gt;&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++=
++++++++++++++++<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp; |=
&nbsp; 4 ++++<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 6 ++++++<br>
&gt;&gt;&nbsp;&nbsp; 3 files changed, 34 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; index d477a901af84..843a3b0a9a07 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; @@ -4478,6 +4478,7 @@ int amdgpu_device_init(struct amdgpu_device =
*adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;=
<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gmc.xgmi.prev_physical_node_id =3D adev-&gt;gmc.xgmi.physical_no=
de_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable PCIE atomic ops */<b=
r>
&gt;&gt; @@ -5040,6 +5041,26 @@ int amdgpu_device_suspend(struct drm_device=
 *dev, bool notify_clients)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *a=
dev)<br>
&gt;&gt; +{<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; /* Get xgmi info again for sriov to detect dev=
ice changes */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;flags &amp;=
 AMD_IS_APU) &amp;&amp;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supp=
orted &amp;&amp;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gmc.xgmi.con=
nected_to_cpu) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;gmc.xgmi.prev_physical_node_id =3D adev-&gt;gmc.xgmi.physical_no=
de_id;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; r =3D adev-&gt;gfxhub.funcs-&gt;get_xgmi_info(adev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (r)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; dev_info(adev-&gt;dev, &quot;xgmi node, old id %d, new id %d\n&quot;,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.prev_ph=
ysical_node_id, adev-&gt;gmc.xgmi.physical_node_id);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; * amdgpu_device_resume - initiate device resume<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&gt; @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *=
dev, bool notify_clients)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; r =3D amdgpu_virt_request_full_gpu(adev, true);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;=
<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; r =3D amdgpu_device_update_xgmi_info(adev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (r)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;switch_power_state=
 =3D=3D DRM_SWITCH_POWER_OFF)<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt;&gt; index 32dabba4062f..1387901576f1 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
&gt;&gt; @@ -89,6 +89,7 @@ struct amdgpu_xgmi {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 node_segment_size;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* physical node (0-3) */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned physical_node_id;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; unsigned prev_physical_node_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of nodes (0-4) */<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned num_physical_nodes;<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gpu list in the same hive *=
/<br>
&gt;&gt; @@ -101,6 +102,9 @@ struct amdgpu_xgmi {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t max_width;<br>
&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +#define amdgpu_xmgi_is_node_changed(adev) \<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; (adev-&gt;gmc.xgmi.prev_physical_node_id !=3D =
adev-&gt;gmc.xgmi.physical_node_id)<br>
&gt;<br>
&gt; Please drop that function and the related checks.<br>
&gt;<br>
&gt; If this is necessary we want to update the relevant parameters all the=
 time and not just when something changed.<br>
<br>
<br>
Hi @Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">mailto:Lijo.Lazar=
@amd.com</a>&gt; and @Koenig, Christian
<br>
&lt;<a href=3D"mailto:Christian.Koenig@amd.com">mailto:Christian.Koenig@amd=
.com</a>&gt;, you have different opinion on if the
<br>
check is needed. Could you align on this? Thank you!<br>
<br>
Regards<br>
Sam<br>
<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp; struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct a=
mdgpu_device *adev);<br>
&gt;&gt;&nbsp;&nbsp; void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hiv=
e);<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_xgmi_update_topology(struct amdgpu_hive_inf=
o *hive, struct amdgpu_device *adev);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; index 59385da80185..7c0ca2721eb3 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt;&gt; @@ -2533,6 +2533,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip=
_block *ip_block)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D=
 ip_block-&gt;adev;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_xmgi_is_node_changed(adev)) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;vm_manager.vram_base_offset =3D adev-&gt;gfxhub.funcs-&gt;get_mc=
_fb_offset(adev);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;vm_manager.vram_base_offset +=3D<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physica=
l_node_id * adev-&gt;gmc.xgmi.node_segment_size;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If a reset is done for NPS =
mode switch, read the memory range<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * information again.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_73cd6a4ce3704d1ab5ae4bb31293eca8amdcom_--
