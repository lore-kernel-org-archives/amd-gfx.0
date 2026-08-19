Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FDDC5DF6D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 13:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0FD10E15D;
	Wed, 19 Aug 2026 13:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KV4Hf6Jq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D651210E15D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 13:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlLdlr7rz0TZcCSjJfwhUWE25PRdvJLnRTgZjGOAff9xQhutNArNwKt/IAVFyaW5H4poPKttNC0WEMGO+ytoSXwrCTbOmcdzhs4uA7Q/DJf1kGL8+FsAi9QuS16PUuKj9IJxCir6+MW/OlnBGb5t3swhnmPYxWHea5dmqPRoKUb9/s6NJPn5KPoww4TzH/HXqN4I6caGP8zhmlrrtSNFbG4AtquLrmVr1InWEE9wb5Cs+g0EjAJbVcc/l1xjQpL9rqHOoTeRqfiU+eqPWsX6k2fOPVLCnGYS/tu6KwEkv1Tn1wQus2l7KfxTMj7YFcvZGFIsyFNtszLXdwQl9rgzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Dt/7CO+T5xm+Mko2Q9Dq9g/u2L44J4uLiG4Yf+PIHU=;
 b=TxPdcoIlYKYtUt9XGELTcmNDaoHMdObqEwGqZXnsh4/iyoouDMFRxw/HEc7o2iEAwUloaeefGyYptNwnKW+y2mPTlhzgUuPQncOvwCR+QPtSFQ4HmeyhtVBq65K+F3Q4tMO4mGgrXo5RQmwiZUu8tRQ5Q4LtjfHriZBwVi7tAfe1dKp5xecbpUP9gZNsBKQf0WdH+ilXoG1NHlWdJEv/lg9+kkIFuzciHTzS969HrcyBlST76XBoHf4V2CYbcbAFlP3n88Lxx3CffbYhw32SGj3SBmvhKs8I3OxBeUct0kDX832CGjoCHjMkYz8VISYbkOd1sFVVhmyeYBlGxKTFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dt/7CO+T5xm+Mko2Q9Dq9g/u2L44J4uLiG4Yf+PIHU=;
 b=KV4Hf6JqwoOoHqsBhAbuzYvzI18rIQ1Op21Gptf4WIuPgX0kri3sp4+CoTCP/ELXv5cwC8D7fhtYIPoKmFNVBJnIT7kpeV8ypsPMBpNwxYI81N8D9/tTbucwR5VLm/j4gPenYu+vltlCPRwnEayAzAb+PXmLWT6XQQq4b6Ytceg=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:37:11 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:37:11 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: skip unmapped queues in
 amdgpu_userq_wait_for_signal
Thread-Topic: [PATCH] drm/amdgpu/userq: skip unmapped queues in
 amdgpu_userq_wait_for_signal
Thread-Index: AQHdLuNnZ8bkhg/8cUKOvhTj305eKralXCXg
Date: Wed, 19 Aug 2026 13:37:11 +0000
Message-ID: <DS7PR12MB60059BF47B5F67E3D576E8F8FBA52@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260818072959.3356764-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260818072959.3356764-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-19T13:16:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB8331:EE_
x-ms-office365-filtering-correlation-id: 491c5634-cae1-40f2-2315-08defdf6f90a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: oskmySu5YaLx5mKaSDz4eFmjSifgbW8crHSsrKNRIhdLIdTO9wTMy9SmJo59j06pLdyZNMFaXb+Bjx9hS/vvx4qAe8Lk3eOBLRtyg8CEqNiP/lyTE6sfv8RsZt6DV8CrJJTaKPJcB8kWdfnomzGF1kx4aXE2bkliL98B+j9Y7YtIU20FlyAtUqwl5677jQWZSPq08NYycaP4hZ4sSBQN/76f4G5KXAaAXgFK+/heJedcfkwdYeRaBoXslRMPX6PPO5Saoy0Xzqo8M7+BV4xMr24yyvY2h/UBbtbyk5VsdfUp8akjTiLust8+hHv4amNZ+n2jFeSCvgCHTQZHirvNYxDrCyrjQCCCXIBxuyZ3omfJmeJXOkQlroLMBAngco7k5OPBEK3RFzawzq8dg32zcYRmo1C/0/QHgqKFA0oGbGL3wVVZiHP9PopsV+5WhyjIkmwioJd9P+E+ZpDHsC4rqlOWLglwfYniMbolWGU06D8dBwIQtmoUm6Wk1tKfhQgPzRGBfATX/T5oMl+hoPiWMGHu7Q6NYyUVRFnNk1+qx5OBvmml9uXb/EO3YHHU2bngFLkp2Lafv/xJcrsIUKMa/lhtx1kLVbpFccuFWCVSqAFkTDYjGFH/gQmmDZU/dBaOVk4HepQiJ8TO/I7qyWtPD8mE54fvurQ2bqREDfr9vjE+pgoPOcgDouBDEs0leAynxuOsv+EwUZySgIwIG9ofl7CMfc9KkpjjZLMytbsaQbU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rtqZviugkxAOizN1pL3ZUUfglf+HaH7xhJTr6WuHrjgB4FKIVHqZ4mYVzzNY?=
 =?us-ascii?Q?cpgbLBGQT1Htck86r47ppGwodYyX9s0Vz1fZ+mFB6bOwQMLyeb4XYq/XkZU6?=
 =?us-ascii?Q?wNReF2JQKpg+LzE06yrY5WRh7umiGmGNVlCBlV9nHGNv1uy3XxrW23jJ9oM8?=
 =?us-ascii?Q?JhLOFyHSO4RaAWmjsIhNQDbw49dUGdaE4K3JIF+bV31W7aQssmHIAlwoa6T7?=
 =?us-ascii?Q?omBScAHjyyIFlKW2GAcuCHUpuyyZojF1wh3b/+vkOHPrb37VfiImbbAgVTG0?=
 =?us-ascii?Q?RYNkSP4TaVkdRU4FQoaVMyLlHfdJnLpJUm842/yGO+2NkEe5tV5N8ijxWuer?=
 =?us-ascii?Q?fv2rLcEfiD2glzh2DK1X85Ggrq8Jc69Mn43kPWx+J/Fj9zrd3/ep8tHIVmwR?=
 =?us-ascii?Q?3nVEZIv6EGShWOM0iaziai43Y35j30FAgFemAsObMNG+LwMJlnk/ma4v83NE?=
 =?us-ascii?Q?CZ6SiIZYI7sV732S/iv2KYQHJPFzIepuCfa9FFQECgtmEgaAT9pmvAVnk7Mk?=
 =?us-ascii?Q?kNWJahlyzACLxU73j8YeEhOwuyKz6tjjRHorYDa9OLHymMD/RuHgjxPlNvsX?=
 =?us-ascii?Q?uguIbiS99IhHOVgbs8bdsbKzpdzg9LWWQ80GzSdovDZdtBP6BgfwnjGnxbp2?=
 =?us-ascii?Q?0syPUjj0MQ0w80SeeDi407hN3IdBR9VG1nJW/QVLBYUKD4wlfSZpHxj3xrEy?=
 =?us-ascii?Q?POipPwWRWJmMOdvgMsUbYYSmlD6MuF8x1OO4qWq9Ly1DiXm5drf6/g1OPxpY?=
 =?us-ascii?Q?pcGacaSyBLgiSIKOqAq/p+4qA5WGISYNw2MfXjxSP29BQl57UNdoTPGS+sZ3?=
 =?us-ascii?Q?KI+brEW75FJiNhp5wvzpEXE5NSJ0IVVTFlb1aAe38pRP5puDQOiW8fw+VUuq?=
 =?us-ascii?Q?55w8k8hrshT5xaYWtWrZzZwH7ERJRAHnz414bpQjX72MkeY24ZOLKMzX9NI+?=
 =?us-ascii?Q?6OVEdStz6yYDX82fg2wQ8M88uVVYTW/Sgcf6sw/qAFFZ5olajrhzSbf971za?=
 =?us-ascii?Q?1tW9ijRZ5PD3mehFB0sman4BNYxl1AWWPgATUhnxNkA9YiHZOAEVIBOJvmSP?=
 =?us-ascii?Q?hXZwP2hgxxfxRlifSevJGgzbu2rIOKgzQAdSoiojiZVac2QQs+3ARfPE2cw9?=
 =?us-ascii?Q?ddvQ0YrT+jnCbxyfvkrqRYaGGljWkFFkCrFQXxzsuoTkAfjvdrIj8DPEi9YX?=
 =?us-ascii?Q?flnGBsgcRlsqlWo4gZwEJmZoIzxVYO096QdzGevG1exPoGHWwoNvo46YLkAu?=
 =?us-ascii?Q?YPa8TBy+OsktzOPvLu8gq6WDi/QSmIXd8fSqk0Qe6B5TfIEEzCf6tnsTq43q?=
 =?us-ascii?Q?U4zYisv8X1W9JbX9at+i9C0EgxNEljx05HXNPUd8U8q65fVH5ISCk2pLMArl?=
 =?us-ascii?Q?ydY/FsWrDcPxfuEK41Eekfca6Fcz7r5AcA1jaw2PAUN+BQ2CDU7J1A3vemIU?=
 =?us-ascii?Q?MGefGK61NRto3kbhAc/ID6iieUzBXw+RsLH0wzwctOn2/Io1UhsO3KIPmUZ/?=
 =?us-ascii?Q?JKrNkOhSQcK+aqXkUwjftzbxoIbqLDFhabPK5FDeDSliB7fpa4V3zPKuoVnI?=
 =?us-ascii?Q?Rip9jN/F1lSYHBRHt5vyWJVbKeZ3WDhkluWAxCsL4Psh/nG8VpVK3NjAxr1m?=
 =?us-ascii?Q?BHayljOT92xuZQ963aS+n0TYGMyBEGE0v4x3XlEMoGbCA10YNnwHrZ2sepZz?=
 =?us-ascii?Q?/cqs62e2KNJC30ISHimkb/ILE3vBPWV7VYwjKu8SN8CyJoGK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491c5634-cae1-40f2-2315-08defdf6f90a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 13:37:11.4685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFRE2nP7eT5dCeLZI65ByjY13XIxXow0qnWZ1F7pxPxFOAHRDyLpgHDEiJBw+NUd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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

AMD General

A dereferenced queue may remain in the XArray. To avoid retrieving an unmap=
ped queue, amdgpu_userq_destroy() should remove the queue from the process'=
s queue XArray first. If there are any other paths that fail to remove dere=
ferenced queues from the XArray, amdgpu_userq_wait_for_last_fence() should =
also skip those stale entries as a defensive safeguard.

Regards,
      Prike

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Tuesday, August 18, 2026 3:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Khatri, S=
unil
> <Sunil.Khatri@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu/userq: skip unmapped queues in
> amdgpu_userq_wait_for_signal
>
> amdgpu_userq_wait_for_signal() does an unbounded dma_fence_wait() on ever=
y
> queue's last_fence before eviction. A queue disabled via MODIFY with
> queue_percentage =3D=3D 0 is unmapped but stays in the xarray, and its pe=
nding fence
> never signals because the work will not run while the queue is unmapped. =
Eviction
> then blocks forever, hanging the task and wedging the GPU on a forced res=
et.
>
> Only wait on fences of queues that are still mapped.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index feffebb210ea..cfbfecb05768 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1302,6 +1302,16 @@ amdgpu_userq_wait_for_signal(struct
> amdgpu_userq_mgr *uq_mgr)
>               if (!f)
>                       continue;
>
> +             /*
> +              * Only a mapped queue can make progress on its fences. A q=
ueue
> +              * that has been unmapped (e.g. disabled through a MODIFY w=
ith
> +              * queue_percentage =3D=3D 0) will never execute its pendin=
g work,
> +              * so its last_fence would never signal. Waiting on it here=
 would
> +              * block the eviction path forever, so skip such queues.
> +              */
> +             if (queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> +                     continue;
> +
>               dma_fence_wait(f, false);
>       }
>  }
> --
> 2.49.0

