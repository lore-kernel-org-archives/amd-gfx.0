Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A054FD29FA8
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 07:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB4A10E648;
	Wed,  6 Nov 2024 07:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yg1NeIFl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF43910E641
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 07:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/1O/GySpNUg4hqMOMjLOacIpXXtIY5azQrPtLaEsJGOptWb+xwEM8FR4WdRXW9Yn9ra5R6Z/q+ZWiQGuhhmea3rYlCZVKrZD3+M71lyYZ/TFY4r8SoLBvNQerw7mgHwgM80e1LHzJ7iz+KRDYIIbbdf1IO9mGgCZm+MM/lHJ9lVH+n3fl9yUwRAN0J+RSILqXQQCw9lxpcbOmepw1kSgF5iWDOHSNYQZL26aK/1DfsUurYtu/mIv3ABoTtD3UK/IK2C3yKGf8wEh7R/FDkNzggd62eeslpvCH9QlHcPtJdmBcmNI77xOxPU4MEV4A8DcgMEmZZDhzjXwZYHMAO+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs+R7t+QKTRka9K8t2FdLZcauAy5TlOtmxbDZLov1Qg=;
 b=vIN3KbBPJ/tJDZkpFVYjjY5gH2fXiwFNpJmAY2vfAoDzV1T1B0ECAV3wdMgzs6HGP6ZTkSZFfREYSIeGulKLlkxBe/T2Hihxse0R5k+U9aTzY7jTaYAaPRCz6aCJ95u34Ubab1S0Gl27PKDbHHa8TZ958ez6VduiGO1dWApTHwfLl0iXDjpHe1xrC0EbflhfRgok4tvHSr+mwj3ioA0Y6TS/J0leP1PduE3yyVnHNXK25OlhS0qJ6zkVvN0C0iuI3Yvl3A2lihHScRzmvOeicumUQCWkOwhCXAWEA9hKk+rQ9rEiLv3eLURtkcj7YWsrLoxUui9P0QG2ccxaMld95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs+R7t+QKTRka9K8t2FdLZcauAy5TlOtmxbDZLov1Qg=;
 b=Yg1NeIFllqKVziWP0fr5mNAENYebyKGO/cdmXH5VUEoqr/LDE3fvFC33Gn5dd/M43C0lwx5ggUmLo2q1vz1lSINBH+UI2FNKsGJn5slH/HUacNMkAtJgqHtPXjU32vu9dcKuhcEPyllys90LYFZraTozodzC8HueQ4+UsP7WRPA=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 07:23:52 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 07:23:51 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix ACA bank count boundary check error
Thread-Topic: [PATCH] drm/amdgpu: fix ACA bank count boundary check error
Thread-Index: AQHbMBmLViSHdJaFHkey6YxGz3LzP7Kp2W2A
Date: Wed, 6 Nov 2024 07:23:51 +0000
Message-ID: <PH7PR12MB8796E25A8DD4CBA627D48F7AB0532@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20241106065839.743458-1-kevinyang.wang@amd.com>
In-Reply-To: <20241106065839.743458-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7014c46e-88b3-4c46-9836-eb2b8dde8525;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-06T07:23:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH2PR12MB4071:EE_
x-ms-office365-filtering-correlation-id: b0342f58-a202-4052-38b7-08dcfe33f6e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JrEC0DxT5+B7Ker6BOAOWRHaaL1CMNr91/XOrGcuB/y3moGsjz+13MxryyMa?=
 =?us-ascii?Q?L59etbmgZ45vOJSRfs/+CHOG/CzNFGKXTv6cdyHjCnPv8tjOY2D1jV1lMrR1?=
 =?us-ascii?Q?0Y1mQxEuz2CMJsIkjpAsE9LJ4D7Cfm7IZuc8Ifzydh3TRz8lO704NMXtSFU2?=
 =?us-ascii?Q?dGVaMklVS3LeTn92ylEWdcGpICUtz/fYdLbdoTi70dcv6PEAQVUjD3OmRqXg?=
 =?us-ascii?Q?ea05Bp1roJlb7lVifvCpEzSCrpX+EYsPdqZwbBv3VcMgpA4uRc4un1zzbGxc?=
 =?us-ascii?Q?eqQRuUblzbti1RVZaUZug3fDBZYRVG44I20lk6cYnUuaj6xKSysLMhQwx1sH?=
 =?us-ascii?Q?50oG7U4+wavE9ZswYB4qMO4MM1VmUGZRqtypOG/pRrc/jwTRW7xXv0yMvqdw?=
 =?us-ascii?Q?mi4hi984WfaCl+zpXRSgHNu8Wi5sYO+u/IwHX8njxlZ3ZgGP+flOFen7BqYX?=
 =?us-ascii?Q?x+daE08UBqhaLkJpLc592pLce5mB6EPf/tzzPGMcqGZkXDhl1z++quMvWPuq?=
 =?us-ascii?Q?669M5X1zjN281yB5mKhxEWCJg6FqB7qoJ9zB5zPyUXuZplzHQhFr4mkw3Of9?=
 =?us-ascii?Q?n5IpyRlF/wPaigI+SguDpMkUrXgwF+4RLvlz33nvojG1cDVOgE7qiV+E5epl?=
 =?us-ascii?Q?o4tIPKh4T8MQTxutDvKwd9ylwIOG5+25sasqfLxqpTDJ+gNxZGBZqo2ORxed?=
 =?us-ascii?Q?lbXogWkvY5faHD6SKjVRSKbgfDDzoZRU5DZl7oaPWWKWf4BBie1sOGtphtEU?=
 =?us-ascii?Q?E6srelk8NYpYVW617IU6Na6i0ugovJHG9sdL7SrbmhLEW0Z7Ep24VA9eA+PK?=
 =?us-ascii?Q?MjkBji6GkPq2FLymlvKXXqfGNtf4Gd1m95lysSnY4PQy/chKDShuKO1+Y5uO?=
 =?us-ascii?Q?tMr27vpz9LRQk1SAccwgrqpThBNXyNNMiZQqjC0mK51ojOlwljUEr+jvEXVJ?=
 =?us-ascii?Q?5kk0m5qHF9r7LyAaw/PfznAOr+t1UyrUK9g3C3PT1kG0pOYsBMb+5zl9ZbOt?=
 =?us-ascii?Q?W6rfwNvWUUh5MreYRNBaJx6p2E06mVR72+WdJjUH8pfzc46CTqj2jTu5gq6U?=
 =?us-ascii?Q?0Nk8hszwJMRoaJR2lBKVaNnvKpx+oh8DO6eHZOt6CyJemj9qX0/qr9jdCD+U?=
 =?us-ascii?Q?nBRx4g8KfcRioJir2W30HScXYK1vwWojwULp7x4sXZC1SfDgFIzyP2DQsNZW?=
 =?us-ascii?Q?FEjleo0lN1mml9EmCtG9H+LMGvweaBEFWbsh9TyCOzNhQlNN7P4esyeEQ7Wt?=
 =?us-ascii?Q?pa+m2En+oUKJ06eAdOH6J0shkw7uHphisyafyObciyGvNSeNXJXsy15A8+Y+?=
 =?us-ascii?Q?jwE2t2ksP3HMLbODMj3DKx9ixokc5bXG3N0Yje8qmV4BToOyhOIM2OQe5wwJ?=
 =?us-ascii?Q?POkxxzU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UiOBq7+yzmnx1jaAkcB1N1JSaSzApiJpSVUgHzAQFHfUVOhsi/vFt1foFWI/?=
 =?us-ascii?Q?E6NIM4TlvmyB1LB7CkevOnCxCLxZxdIdXzyTMeAKzAaQtgTVzF3ynaJ7DlUp?=
 =?us-ascii?Q?vEDid2XKAsLKEm32uMB6elVTeAsNde6Hy7yeYDvPJRYoQHI3lXgPhq8CA1sv?=
 =?us-ascii?Q?CXwLzknyBPLzYwX5TYv4SwxsSDDOnZBwARyU3HCWnwo9fnxcB33LHjbQu00Z?=
 =?us-ascii?Q?SqYYloH6SFzY1D8s3iEy6fJutUwI/Prd+f7P5TV850Zil+AlkppEwlTrv/4w?=
 =?us-ascii?Q?zX3SEVwKmIs9mlMrZtYSWMvY05nPJnogfUR96V58C4rU/2oXI4uuNKb0r8/c?=
 =?us-ascii?Q?GNmZUoMNC/V+WmmI0aat/sbHtNMRwaoBzaHkUmWIfXe096em1ew2r8AyuOG0?=
 =?us-ascii?Q?KZ70Uu7OCAhVcLYRF0YwWqzW4LTGbg0kcujcmXQerHUPPEXbiP5JuJLph9pD?=
 =?us-ascii?Q?xa3I0VjndZGcYHatDsntqXkdBaSIUxHCECbcY7Py90S91J5Agq9JvRj0I3Na?=
 =?us-ascii?Q?TwScOKyMBfsSmd/JCrUkvHno7UhuRxffoic+nC1gNALj/GcNdahBmATdAwct?=
 =?us-ascii?Q?l0IcWOWgMTWoERRhaFhouwPhidrWIhj1DRhQEcQme4FwOs94vgPOTgw7jKPa?=
 =?us-ascii?Q?HHnIVOKfvFAr4DEg8y3m0YnsoaT0ZKYXzwWDrcIbPnCnMZjqzIY6WbXb7bOd?=
 =?us-ascii?Q?CShY4e9eMTpZyBSPArFtyJ5KDHBJcGww58aMBn83Oe8I+6nybNTbp5lVFW9E?=
 =?us-ascii?Q?eRd32cnUiUpgdzradOb6TxG065ED5MNfYbSpm2FtjPgBPTRDY5qW3zi/2Qie?=
 =?us-ascii?Q?G5gXqQwq88Ma2Rs2xi2UjL3WjYtaVoouZqgKoKY7yLVXnwgF2q0QBJpq465p?=
 =?us-ascii?Q?4xJ0/aDplG0i3s1INqUOsGpP00RBW/5iURybUObkWLMOz3XeqTsbKRMZ/oKS?=
 =?us-ascii?Q?zrl5X+KoKiqfnGAX6H8gaDLUb7YIMGLROPn+55U0aeUeV6mGMkKUdal30qNB?=
 =?us-ascii?Q?RPkS7dRw8pxRuagUDWjwXGEcCgR9D2cs/adpT3dU69V4PaJv70ULgc3j4dUv?=
 =?us-ascii?Q?0Q/+UDv8MsWiffeMy8Ku3+S2cuyjW5+cUKEGPqj+vj08NV2YzsGooEiFAbBW?=
 =?us-ascii?Q?fsJJOMiSALaTDNXOXQ4MduaovabdGBQ9m67wcsSHDnNRHk7exXSLJqO7Jb+0?=
 =?us-ascii?Q?pjma6dW9BdRiUhe7qzeDh5Nc7wh2QYjfoIlqIyq1h+uYETSt2CcfrxiGIzje?=
 =?us-ascii?Q?H/WajB3bEbQ3K5OkPgWHFRWDgW7VMjGLA95VbtaQPIcggdCIf6Ih9WZN2019?=
 =?us-ascii?Q?k71dsf/EdMSIZAwS4Du52C92HK5esy+AEuQWhUzCrNOmV8SWxgVW5Ohyv/l4?=
 =?us-ascii?Q?i05aaIjGwEerGSGQ/+jV0Ae/Izpiux4og7syudWJzemXC8TzWpzi7dqcXqD5?=
 =?us-ascii?Q?i+ZFdIypU3+TXl7jeIariCCVkjuWas18VUjQbpCQNfcvZ4gCRpdWsz9ElG5A?=
 =?us-ascii?Q?tL6fIOeGpWqAXh6g9deYVc0U6pfnLDudoSBzH70Dbkx2oxD4+kwWkx0KCPCa?=
 =?us-ascii?Q?LPnf6rWlhXo0w/s1mSo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0342f58-a202-4052-38b7-08dcfe33f6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 07:23:51.8356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBRCSBkACh7w/viAOar/vYMPIiUnFm4o/dYZlWZqlYZ4kyk9AcdjB1TJBKqxTRTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, November 6, 2024 2:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: fix ACA bank count boundary check error
>
> fix ACA bank count boundary check error.
>
> Fixes: f5e4cc8461c4 ("drm/amdgpu: implement RAS ACA driver framework")
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index 2ca127173135..9d6345146495 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -158,7 +158,7 @@ static int aca_smu_get_valid_aca_banks(struct
> amdgpu_device *adev, enum aca_smu_
>               return -EINVAL;
>       }
>
> -     if (start + count >=3D max_count)
> +     if (start + count > max_count)
>               return -EINVAL;
>
>       count =3D min_t(int, count, max_count);
> --
> 2.34.1

