Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8697FC27C4F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 07:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B8E10E960;
	Thu, 13 Jun 2024 07:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MHA6I/Mk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4A510E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 07:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsYqbRJW7JmtxBZ1oIMOVUUzf9XmoGhqmw1tqay6vmr4XOw8RkHHA5EuAHIY0XMwOF1BB5sFA6ecQO9Ki/fI5z7ePYPUPzZQacbUQQNyRSqQoAaEbl+2YrT/Uf24xzP7a9iZtvhYqRhP7T+X71E5+mfnTkY2mZN8nDcBkL6O1+q6bc9DVh3TdCjr5T+aEGR8k/pAk78fP57i/UYYxg8ZVtv8GBNEfO6wV0oJqSRPU+N39bGh4NylOZ8hObn47bz+mNlXIG4CTNqhRnKMk5nK8Yq19fd/e+jaBPH9bEzNQLl+ZUF/sufYMthgiUBbJi6zewHq4F8j3JlQI2wa0mzoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGIANKwVdDh75+vjm4p26YTB5R+vFNej/LniS98h6rE=;
 b=S293lUDT/ylLT+IVAVESJ7zHD9fgwdY2uwp4lqIPnCZA+4s6ejT1dQim76lRjayPaeglTjir1B8qIOAGoRbC9JV5Y5gKykUPbep48BEssRlIjdIynUf8KxNpFVmO4/uEL2PsdxcUtkb9tpEJb/tTQNFPkBX7woGutMMWw9H3HDAFy+OgqOdd7cfx1WptXHinMhT9G9pHjPUic7onXYXRZIBKklUjkQewtI+DQn3mLv0vBTWUNnsye+rlnXJNBVArJXc76vVk6MMYXO2q+ih+R7A/m0vW9MO8ZKiDBm+VTXlFqVheejaCUeblpgt5Jbwv19OEnWAvStNhNYDgBAHwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGIANKwVdDh75+vjm4p26YTB5R+vFNej/LniS98h6rE=;
 b=MHA6I/MkKGq7F6kDZkrBnaWIloPHqHwZaWU+0nQVuShB5WzodPL4L3/712gMSCl988QW6aPbQqizfb/VbjhAaMSYJ0VRLzfrHx/1up45kbXbfK7g6G/u9GtZHuydjfXHAdOWHa1qJQRP+zXG1pIuiW9v0sKZ59coJQ+cJDaa4ZA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 07:01:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 07:01:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdkfd: use mode1 reset for RAS poison consumption
Thread-Topic: [PATCH] drm/amdkfd: use mode1 reset for RAS poison consumption
Thread-Index: AQHavV7/oLMzmjQWS028wYUkUvoPH7HFRCLA
Date: Thu, 13 Jun 2024 07:01:19 +0000
Message-ID: <BN9PR12MB52579E842E798B1B705DC563FCC12@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240613065726.30129-1-tao.zhou1@amd.com>
In-Reply-To: <20240613065726.30129-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4cd84ff9-b4a5-4aeb-9da6-62524e9b88ae;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-13T07:00:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB8088:EE_
x-ms-office365-filtering-correlation-id: e44913d6-4739-41d3-e99b-08dc8b76a07b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?us-ascii?Q?9ALI+XQiBq5/2aN1uwMxINL/k6u5DspOdZRzeLosz3R6IoXHLeIpmMwws+Pv?=
 =?us-ascii?Q?WdqYr2lzwz/Umrl8dTh0OsBR6BzkADKMBPI7LYIiwRGu5Mx2krEO75sHsrJz?=
 =?us-ascii?Q?4BiXqeIu7DQoNmo7f16GdlIcG1B/nvBdQfRPJMfjmQ+9X0wDZt1ZHpHy8t7X?=
 =?us-ascii?Q?dUPfqCkfO/Cp9pXPl85FLOCQ6pM2mH4D84bgKx+OGQ2CfUzUV7PijjhllcQP?=
 =?us-ascii?Q?zPWKePQ4tRTuOfWgpvywCDKevodDVpQbzaifu+5nTM1tya9u35RRMsJslEx7?=
 =?us-ascii?Q?2scWOIvvZKGQbrawgqtOzQEA8ur4UqltMGmetxLzXciLiLSkZogD/iCR/+hn?=
 =?us-ascii?Q?75jnYrT9Xd/KRmBTZ4WalgVPzIQJhtEXUxYUJSIwVvXBsMgxxq0bxhwXOZ4L?=
 =?us-ascii?Q?55WerzZyJbBVHv0M7nn67/N4TSy+g17VRuuGNxVjXlplP+Bn0+6cMCQwJEdd?=
 =?us-ascii?Q?vHhFHxTFTPVBtB17Dfg77rCErg7EJV+1AdGXh8Iuem5boUmjVtUeHKULrr7J?=
 =?us-ascii?Q?sXDm1k40mQ/bYvahYtVBYg8LkrbdrOQeEBJDqzq2w7IOyLPuQr9FgqE0Uq13?=
 =?us-ascii?Q?/KOzEACg1kgmMTywe0m8Cv3Hz3QfMC3l358lclCbMujy3ix8YpZx7S+psVPO?=
 =?us-ascii?Q?2gOtCk4OWiMFAm9xvO+t75gbuO2TC1eR62Qj7DZA7KzvURqabCKcBxChsDVE?=
 =?us-ascii?Q?aNOeT2zYsCIR3/8tbqgS24CU8iudIpJfqbDhN6Vgn66sOpZQ8tQ0KpXAJe8e?=
 =?us-ascii?Q?6g2vipSIOYZbkWeO248wKSB+uu508tK16D5RLPLx+OJWff/YPHIdwdX0bcjv?=
 =?us-ascii?Q?T2h4xVg3GQszA5va4Z5vDmFTmWp5AoiPCJtmLIxrr2Cw0AbjC03rbvP61COT?=
 =?us-ascii?Q?q16YGeHgn1kryVfEBObbBRLL0F6icEvcV/XfK1sv+0sUauGf/zlsrnhyEwn3?=
 =?us-ascii?Q?m3qSN6vlh7rr5s4GQju8nDc+8cq+pBbieEIFstrj2rrG+YeDh7vwaxvp/GIK?=
 =?us-ascii?Q?24K8zQu3iy5mNyUGdjdkul9eghEp/j/PYuikD9uWeekvHt1WGQ2Cy1hEsEeK?=
 =?us-ascii?Q?L39RKa3jqcOjTXm0dFdWNhATmmgvCWSMDHscncMY2vSvvY47nGS7KiRVHy1f?=
 =?us-ascii?Q?RTyliKVDjXHJbLKiNte8XwZq82sZtXZlE1ixZtYwpkasr+AU+xZ9AfCCQRIJ?=
 =?us-ascii?Q?26j4q8HtFrbL57+eOrhQj15xJ7r0Sc81t31250FzbMk9Vb5KefeETnpybpZy?=
 =?us-ascii?Q?oHME5UGg5zA1G1Vkp5KJvQqt77+zKBp3VEHDTdBw3YpfFwGZ77QJpTS0akkS?=
 =?us-ascii?Q?nhojDo8mT+2bVKHezNv6R8NL5e4nIguo3BAJ7w2ZdaW8R+HKGb0VSONjp38b?=
 =?us-ascii?Q?rLwIE2c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(38070700012); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IWb3rYDl3bIXoljb7pv96UQtdPsDJpy6ZoSTa1mUzap5Mf1g1fJQY+GYtgPM?=
 =?us-ascii?Q?2YhUGhcwq51LNr9y6O76/F3ibG04WCmz/nabADM1jGiD0mwc0cIjOlKKjjgY?=
 =?us-ascii?Q?1RoYYtfUJyMhRXAHEYkVvd/HRjkniIXCAHRGHB++zfkBiCY34iSIG1wadhE5?=
 =?us-ascii?Q?Ca1hpERDqeWIdUz/G2vYrfZqyCPeV41ylkVDxqVxwvbQdmcQqyun3/W54MUe?=
 =?us-ascii?Q?IdSJ0ZuqH4/fwZjZBqo+hSJe3EzHHjZp60Cf4WmlBacQ8Yp71feMSnPeYxHo?=
 =?us-ascii?Q?0zd2cHQLs1tHkrM5XqF5WysW+v+kJLMbhfp820tZa5z/jdlKyd5yjuZsX0jN?=
 =?us-ascii?Q?c3UnBAjoDqIQB7pKfnZyu/0vDkImBk9QEd1C4dzW3yP3KjhnbEof59n3gQ4S?=
 =?us-ascii?Q?mNhFQQ6HhGpCOh/OQQPe7pSNWUcPnIX03UQMw8uTd9NMoMz0DeMjo0maSBfP?=
 =?us-ascii?Q?SIGwE8FbxCeE8DYTWl7Z0eqg6qWQixBuBBqRmal4VbgjswUVoA+okVrE7bWR?=
 =?us-ascii?Q?iZrgcpJZfnWHYwayZV+RiAC0t22Fdv32vkibLOjF+Tl8O+EHD+ejD0HFs2Pq?=
 =?us-ascii?Q?Cm6giz0bex38eU6VT0yqqTckvFOafzgzwWbCED5yjLZKMe237ZZI7Ha+hrxV?=
 =?us-ascii?Q?NZ0TN1lgsYp03D3f7AX7/Dxt5jbgi+j8OHcUo+EuF3h2TGtRTpJJZb0RF6Vd?=
 =?us-ascii?Q?Hr+vACpJVahcQcAtVj9Xfzeu0IT3zEpT2XjAPfr3Xbn2VE9ftTXGjlmqkr/o?=
 =?us-ascii?Q?7KslUezd1UtxZrIyXmAKIKfGO8AusiSOP3GRavaemsDT9xslDWhBut9b8jr+?=
 =?us-ascii?Q?BlfgAfs9G05LDHW8iu/zc1yuhtzV3KiRkryHgv3jhV6y51ZJxkPmVX5ahryk?=
 =?us-ascii?Q?C6RY/+lOZCmm4CctdSY3dZRADDeNTQgSLqG9E7YYrrp4SQ9XN3gHLafQwu1k?=
 =?us-ascii?Q?sOM/L3pv/5+lPzx2uYFER/ChHmHm0R1YyKFr2EWd2FYiMt++x7Qgw0TaD1ut?=
 =?us-ascii?Q?CCbMYKhwEyjPaLF7XtcwoZ+S1+wSY8xtqtHyclzTL5Kj/04Bqmbey+9Ebzxt?=
 =?us-ascii?Q?QnXy+jDiTmsILj7lZT1Axtl5CZ2lTpqXv2MvF3j4urY/q+wvCSQ8dvantRW+?=
 =?us-ascii?Q?YsLGkLB89QVaVMQcQAu8pMabAPjtPJ7C6Eab3FVUshTI5Pp0wVofrvIQtmP7?=
 =?us-ascii?Q?RyEm7og2NBw9Mh4q/t/fLfbjOA7Nlr5JVPiRLIPBfDSxZvW2PrUv+whw823f?=
 =?us-ascii?Q?pvboM2MqwtVPO6wCGu+O94ErYm2mJRgZZlUi6EjOzVjfFJqzQhQtyY97qsz7?=
 =?us-ascii?Q?L3mmPbvjzZMsVoxi+GsBNQI1BS5p0afKbjP4KJos0xF09D52KxVpJBJs1Kwz?=
 =?us-ascii?Q?GI9pXLJVk69ESm5xN/CzBLTuV3CDSryYk+QlQnFu6TLsnv1dDdDj6smqXl6m?=
 =?us-ascii?Q?hcPG70bGfKWZjgzrnWv7GjbIMUxVEUgpoLrXvXRP4bXZQG7596b1K0di0fLp?=
 =?us-ascii?Q?kHkaXEe1T9OorkJ3KRGm3++DnElXspX5zwfHvHCSnk+ZaE90xIfzzZaZwF3l?=
 =?us-ascii?Q?PTr7QkKFFeErfv3lDfqYneUdRC9euxTlXelcukYb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44913d6-4739-41d3-e99b-08dc8b76a07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 07:01:19.4323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APsUsZRuIRuCIXmVRrw2MnfCtwPtmg6Om3oHFDBqkOwyCuqm9nTORABQdlVNnhbt7gUcae/R64GERQd/c4ahPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, June 13, 2024 14:57
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdkfd: use mode1 reset for RAS poison consumption

Per FW requirement, replace mode2 with mode1.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index e1c21d250611..78dde62fb04a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -164,7 +164,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
        case SOC15_IH_CLIENTID_SE3SH:
        case SOC15_IH_CLIENTID_UTCL2:
                block =3D AMDGPU_RAS_BLOCK__GFX;
-               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                break;
        case SOC15_IH_CLIENTID_VMC:
        case SOC15_IH_CLIENTID_VMC1:
@@ -177,7 +177,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
        case SOC15_IH_CLIENTID_SDMA3:
        case SOC15_IH_CLIENTID_SDMA4:
                block =3D AMDGPU_RAS_BLOCK__SDMA;
-               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                break;
        default:
                dev_warn(dev->adev->dev,
--
2.34.1

