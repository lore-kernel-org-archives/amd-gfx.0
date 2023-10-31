Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC51C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 02:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0782E10E3DA;
	Tue, 31 Oct 2023 02:23:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639E510E3DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 02:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlJx9aX/jvFD5O8Z+3yBEvSS2WSMvMZMky3IqDh/1aGxaTNYQVJ4ofZWzFz/4pPmaN7cQkBWAnV8zOiMzPIpsxY5gyhNVfR8TQiseQ+wZLMvYAfqAy7G27tYaB+szxwdfJMj17G97leW6ZHn5OEDyQXCU3xnmM5DS18mZU17A1yWt66eMT+dRtPXi+mQiaIDF1U2xhh97jesbLMrBz6Oki7Y11rQ76DEHzeLzodAAnb1PaULeQIeAnLsXyuXCarH0dGemlAe41cZhX5V6og2uGfBppaUgIewiirf9DSXJ0QWgjsUYLvi/pNRalKvXQmBYyU8kheuPsfN/2WJUO4bKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox5D2oiHb3KWjXLwJkc4KRDcdWJVC1oYdhumjnrgD90=;
 b=PRF1le7Jw7tI3zdB7fYjdhGJ3fcNv4ZxL29VhYVbEPDRGGwn9hS5pQZJuE4KnWbDmfd1MX8jfMjbua+GeROgxQcJV46h+htYEhVrGejIP6Ef6I1SdfiVwrm69Llaz1qzB0r9X56Z6XwJ0TZXbfd2Fg9aJD9CXpw0k1U5LqwdbDv2tbxJzKi1dsk5Rc4f3qpMIozciACJZD0Pbg1cftqdJQCq9z3LPUsmRtd5LYjklFGSQJE712zAbnNNkj3BmaoYBjt0FbQRb+BW2pg164icedjZZkBhL39MJfWnfDwdSh3p9gmNt5NsY4kI2VSnQ8V6xH3+ApQ7/WIJagz7v6oshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox5D2oiHb3KWjXLwJkc4KRDcdWJVC1oYdhumjnrgD90=;
 b=jNNHIXHw9Fbe2KgUyQ3WepfCSjb4Af8Hg6xtidqcwmm+5ZmVFNtQQQnPGOQHsQLYnvEW1WPsEVdx1FTi/gn5EDo/qI7oVQmAogCuLTrIEGfplN6XkkX9jKJ6Kww1Hy/gv4V0uZSPVlQgqaV2KLerUukbmVPqOQ3RCZbIVwq57ng=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.29; Tue, 31 Oct 2023 02:22:56 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b%7]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 02:22:55 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove unused macro HW_REV
Thread-Topic: [PATCH] drm/amdgpu: remove unused macro HW_REV
Thread-Index: AQHaC5/Ek7qN+6P1O0eKKnB3YBODKLBjKwmA
Date: Tue, 31 Oct 2023 02:22:55 +0000
Message-ID: <DM4PR12MB5165A8AE91B019ADBF31824D8EA0A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231031021236.2682661-1-kevinyang.wang@amd.com>
In-Reply-To: <20231031021236.2682661-1-kevinyang.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=96aa9d3e-50c5-414d-9abb-d62a71de0be6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-31T02:22:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CYYPR12MB8992:EE_
x-ms-office365-filtering-correlation-id: af9a80a1-f505-450b-ec79-08dbd9b84b0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7h4gWM2JRMvwR3Ss2li98efipUaDQH9yksK5EsUBKPmOUb4iGZmU9VYkhmdijwc/bQZZ+XUx7JDXVynYdFY4D+ld6u7PIjmBYYiBU0eWqnpsQ7QKCYt6ypeGNiMFOsNDDaDbUa8p5ZCotsAn6K0IMsJat3bQBhujbCg1TARw33bBuWZdE1KhICwb113Gp32NcH12h7h2skuus+5HN2IaymY+tHAaZW0p4bqHZh4krPglwbOraaeUslE24LTj96LtsEhekJXPRPZn7OEKhQ7ZQEScNpHMpEyS3mrUQ+C/WQih2uG10PzVqzwI7Z/ITCzcTTOUL3vSTztfskWqY/BapKvTM4DFh72eEWWeIojBzlpC493FUasP5pWmyyv3luxLwjopAVoETxVovnmnBD9Epu++2MxCik/eIpE07RgFUDL8Q+uEcIxGeFaxZqmOlfni8QrTLwG7SwdkMQj5IecLTvkSwXLl3uzWH4z3NUPtFJkZl6tF9mqgfJQvl5deTAzjmjPXjcDWwJCX7T4rg/t+QqMJWvZjoVOJUFI4aCrIX0FGeLqe7/gwp2ePJxa6DepXUVAjvHOBIFVLq+02R6KrJJmjaJS3+z/o62R2Q6aRdOAr+LLi2wxtqO1zpCkyqIFRmniNkjVCFo+en5tarSVKuMtAX0BBvqC8IoOobTFPlnM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(52536014)(2906002)(76116006)(316002)(64756008)(66946007)(66476007)(66446008)(66556008)(83380400001)(478600001)(41300700001)(8676002)(4326008)(8936002)(110136005)(5660300002)(55016003)(71200400001)(33656002)(86362001)(53546011)(9686003)(26005)(7696005)(6506007)(122000001)(38100700002)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5l4uqWPRoI9ENUZs2xZ0AgJ93j3MmZWlpjElDx9+mD6f/ZMlldu528dqiEoE?=
 =?us-ascii?Q?4DlFYBPJFscwA9D8kVLLy6k8Xz9CE9GLXJWzMo+siLGAQDtiuzSd7feuY5H5?=
 =?us-ascii?Q?MSxUqh/PtK8g33vGmUkALvpfxcAMrq9nfFCXxVwEEJ5qmdrJD6wX6DLcyQVf?=
 =?us-ascii?Q?8Uc2UNCswsUgr2g4hNyng9xK7S4CZ8N1pp5E2YVs7e5KNcrUjCUgX6UAf9Z1?=
 =?us-ascii?Q?rG/iIHkyh5okb5MsDXqMkN18WWI3NxVRRk63vts0XdDawlSGRt2P+6XDnI+6?=
 =?us-ascii?Q?cSA/dsxFLraorrCW55VIJIN9aK1BEFxWnsnkFY0OEdwQfoa9pmrawuIUbJVn?=
 =?us-ascii?Q?wIp0Cf78cK1dBPENsUKYScu//cmCwfVGYXTY/KM7WJ0/kbdHoNfSvKk/UIsI?=
 =?us-ascii?Q?RabfVPhVYE5V+1m+qk/m1/rNbUi+2p67XblIkjjiN5bs+NLoo9Ukm7tEb8L+?=
 =?us-ascii?Q?ZSQbLMVEL3OVoiPFkF3V3e2rRR+cg0IIoqiCaaeW2xYEqc5NXG9Z9IBQ03Gh?=
 =?us-ascii?Q?YOPdcd47dBrvcka+yMmLzdzgbH4PskEgBZFyBltT3QphzhL/sqPeZHQCOWrG?=
 =?us-ascii?Q?vKYdh7KjTRtVtVMIhaT0JGe/V6XOm2wMZDRbwwx561jicD17Kul9smCMJjBr?=
 =?us-ascii?Q?CdZBpAjTPeXwtjnU5I5YdUS7EJK0ClymV9Nl60JVR3p0z1/Ri2hhtnFec4as?=
 =?us-ascii?Q?Y/4t9Gt8BNrYJbrMWAZKCY24TXRg0FVAeumNCNgyAoo//P47q3Uaif79DAj+?=
 =?us-ascii?Q?lUpw/7HXhVmarY81genxmquFdJd4TDc3kC76cmq/v8+YCi+SF/CbFTzz6Ql+?=
 =?us-ascii?Q?fkNfmGFFC7DdsW4Hmf6sVXgHxTloyPCm9wB/hfRndLijCPS7f+M0m+XsL5+y?=
 =?us-ascii?Q?P3rU653KrNHGllKs7L2DKIMwbSpqvqZwapjA2nuqNzbBGIJeLyKyWd8abE8V?=
 =?us-ascii?Q?xDfiMm7CozkLfMF35ddhdTAlAvfnW6J7kT2jnhTBowU9EvVIpEdWj2GQJmYD?=
 =?us-ascii?Q?Z3yFEQ1gXEjQ3Jy3Rj/1EstLQtssdIFbc4VOLdEOGINwf6HaKUcevv244z4/?=
 =?us-ascii?Q?q2r0d8oOp7lnfk77uJdiI7jCq5bAoyhHEOZxv53FKoGaUzvp7TlOHDnnjm+I?=
 =?us-ascii?Q?5M/fiq3BM85mk7/mmpLhOu2ZfJKi5NCcrSxyfQqNpkFhKxJTSjgPOj4iVH+A?=
 =?us-ascii?Q?Wl8TTvUMXdTLaK4UyvDRE+ONLO68wkYv/lNPPx0hhw/c6rUrwrsTUCMTrH7E?=
 =?us-ascii?Q?YdBkONq6ZlECwofCmF36n7JGKsqrtbCIIvR8vSxPtLY2grTQ3zDbKT2eNUiR?=
 =?us-ascii?Q?7YMp5MHOkg6yXgbSbE69FxxOS3jtJ+I0GJCcJ56fHm4eob508Ica8Z7zQ6Gt?=
 =?us-ascii?Q?+wZKUXDOypsGH34EecXKKW1RUUI19Me4OGTOfytjS0UJpPbavwY7+HxIIk8D?=
 =?us-ascii?Q?ribi+ZCpyZePE/9YBFm1dl+9KPcTWegdJY4yoTeSw0dOsgnJatrIBnZoyMEo?=
 =?us-ascii?Q?FXYCQc1GgDDZAXdwh7EnWP3EYX3opQOTqthtErmW41ESZejX87g9sl+TNUqK?=
 =?us-ascii?Q?YeLMW+DS+E4sEQVU9Nc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9a80a1-f505-450b-ec79-08dbd9b84b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 02:22:55.9066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0DLB7sAuJ8rzE6/rE2r9nNqYUtrc6Uhhnby+XnnmkhjD6dMqGebvuek/C5/LZIh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Tuesday, October 31, 2023 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: remove unused macro HW_REV

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


remove unused macro HW_REV

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index a2e8c2b60857..969d8ba8b8dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -365,9 +365,6 @@ struct amdgpu_ip_block_version {
        const struct amd_ip_funcs *funcs;  };

-#define HW_REV(_Major, _Minor, _Rev) \
-       ((((uint32_t) (_Major)) << 16) | ((uint32_t) (_Minor) << 8) | ((uin=
t32_t) (_Rev)))
-
 struct amdgpu_ip_block {
        struct amdgpu_ip_block_status status;
        const struct amdgpu_ip_block_version *version;
--
2.34.1

