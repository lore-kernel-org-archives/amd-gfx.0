Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E80CC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 15:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0124810E3B2;
	Mon, 13 Nov 2023 15:05:23 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8928310E3A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 15:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzIETVibIkGS3e9ULNIMi/tsnEJlEqEz5Wmypk0HpahAJgW//NWRbHhFsJv/yYoV/IGZrK+TFL2hyRLWJBsXaRO2yJh71RV/a+TqtEtzBKFJNkjUcqNy5JLkL4tXxL1yZ+5n+eKd/9g0yjgiFt6qYyXHg4fkwIML+IHw2u7f/JEzln+jDpTEluiWumuh1QfylYjT7LlzJ2NaRKmg2USDrXk2KMonQuFemj52t9aClh3geozA6yoFNY3g31OMN0P8MKgUB6eUZTabbzIdQcR34VivD0Jj1Lsz2qFo+hSkdIc4UFCCGODVDdZEIo7ApBKHLU7d+XyAStlnEqhvG37pPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9Mz6WWl2ePsaNIDs2FZ2v9yYsq5YEVBF+dCYar1tgE=;
 b=lrkE0QxXfG9ROqZHUlF7DzPlySwPFzTZS1DAcS4aTgoJvyRFdXufSlqUDMXPJw0080xluzeEyRR15jDuX++jAbb8OwJSVsYtp7vaQmnSTYkyfi/S7KPfuo9kCRM2cDAKuVltEwEw+jjhU5C5K/YmrUype5GglE+GmO/cJYjChEKQ5K9XFqxFGbwp4vnNt6uzF1gP8cejBx1mY7oJ7AIpIM1/kOiZcZ3CCsTY9D2Y8WgxWoayXklXarumw2l4p9nOjgPOqR3GGf3p5lm4TI6qqc9PyrrRvm9xOz9T1IGuJYlnF/5oebENhHn0ftZZm9TgNTpxiPLJHfR4VciVGKQ80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Mz6WWl2ePsaNIDs2FZ2v9yYsq5YEVBF+dCYar1tgE=;
 b=PwSf2jBCRligGjJnTiuU1zJhq+EA1YB7xa7b5fPpGZzBg1MqfGdNO7zO+cmbVm/3rXPoqoKZ0zwGLEdVLxITt6gdTMcc1tAAqavlAO8yQipV6lXsH/+vzy6jCa7FDRgx8BV3UQmr9SXziTMOnKgm6IrgpMRUeIViFUDHVoeKOxs=
Received: from MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 by CH2PR12MB4921.namprd12.prod.outlook.com (2603:10b6:610:62::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 15:05:17 +0000
Received: from MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::f786:72d4:735c:aa84]) by MW5PR12MB5600.namprd12.prod.outlook.com
 ([fe80::f786:72d4:735c:aa84%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 15:05:17 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Do not program VF copy regs in mmhub v1.8
 under SRIOV (v2)
Thread-Topic: [PATCH v2] drm/amdgpu: Do not program VF copy regs in mmhub v1.8
 under SRIOV (v2)
Thread-Index: AQHaFCFCtYzTirdMnUqbbcZBB3i+DLB4XU1A
Date: Mon, 13 Nov 2023 15:05:17 +0000
Message-ID: <MW5PR12MB56007B064C20AC90483A6393E6B3A@MW5PR12MB5600.namprd12.prod.outlook.com>
References: <MW5PR12MB5600A804F2DC648D9BD863B5E6AEA@MW5PR12MB5600.namprd12.prod.outlook.com>
 <20231110215933.3265-1-victorchengchi.lu@amd.com>
In-Reply-To: <20231110215933.3265-1-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8510cf18-73cf-4961-823d-f7455341ff09;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-13T15:05:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5600:EE_|CH2PR12MB4921:EE_
x-ms-office365-filtering-correlation-id: efa588c3-d2f2-474f-1e72-08dbe459f24a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12SNurk3ZO4sRu3zBEwf7Obs3UjVb6qu74sLqzwUKc1vzKsDQyp7wR+aha8UNPC3VY+sjCqice4zdQECEQSfIETljd3tWigq/JjNW9V/2+JV5G60znKo9XsSIw+HDtQ1teje4D5WAPU4C8EWJzu3ul9BMuaWqse6cQYU5zU1wl2Mf+UabRM7V+DUSeLt7OmXtmk3kYgQzRmbFlno2+Jq+M9OfaOHR4Xwf6j2VX1z4EcQetF5Lkg2XL12BRUKdcJQIydZ3nYG6cnskNf2Zb7JzyHZ/6ZRGyo7gEEd+l98KSWEZIoeMQBzLe8iS6/xf7lHjDN4YgXdSaPYiDNkx+/Td3uVcoma0UbGngJx2zjztp1VHq3nlwQ4rICn5Wa4JyzTfr3MVxlaZZkfBSQZi96TrNqOuSyX42/8705M2LB4XUyXSYmAuTdmIxA3SgsdpSKYsstvYCTAy3tMYnCW2Z5rYXr47Ijul0c4uGBrlt5tw7O/QkSYHjm/513DAnbXUg1X5iwdu1Z5bxGG3j9VGuOZne4zDorb/IXVeJIbjlhi2XIrg+XfgPfXbsnqd2VgAuBq3bvPVkqXb/xlr6j/MMeVTRktVZ+JS+NfvptKXyl+6wHsDWadiM9ofCybE8RkKboz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38070700009)(122000001)(83380400001)(110136005)(26005)(478600001)(53546011)(7696005)(6506007)(71200400001)(9686003)(86362001)(5660300002)(55016003)(52536014)(33656002)(41300700001)(38100700002)(2906002)(8676002)(8936002)(316002)(64756008)(66446008)(66476007)(76116006)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t/jBqj40pb8lga5ytCw9iMr4A62LTaVfkwCNvGHeEelkOe/8lpzClShXBD5k?=
 =?us-ascii?Q?e2u8Fy9CHCFwv3Eb3k9zvZYObBYbPrPj36DnBVgeYcd1ZK9jjkroV25Z6GCw?=
 =?us-ascii?Q?Tb1D1csU+CZ8RYbEXDRq+GkpyqryMGwqflr6Mlo+ypRGXBUUfX1LTTfWDGMA?=
 =?us-ascii?Q?zLCRH6cGPGykO2iWK6uV0+0JfuPxWF8Sw20rWZmg+zVtmybQIcF0ZgrLk2hL?=
 =?us-ascii?Q?OKCwC4u9Y8ATVTBzF3i3YgHudwixJ5aoLBd30oLqjdfW7LOvRa6aXsLhV9z2?=
 =?us-ascii?Q?iDq01sm08a0xg0L12GRRj+vsOkFr/xnKsQ8+TlNhfh4T06V8AqX0283uUUXi?=
 =?us-ascii?Q?ytjcufndR+zRci/4YM/G9RQQ2vlNr3oXm+UNZR1WcCmADbMTkXK4mGnc3jxl?=
 =?us-ascii?Q?ahF5u0B17bYS6c9PHIvq9ikq9TDMdD02Sth0+3gh8sQdSH7EQI/NQIpKYgt/?=
 =?us-ascii?Q?/xA0+dM1gO72jS+CXZIAQp1NI6O8/yBDdUN+lDibteIEpowfjnWAMcWuqUwd?=
 =?us-ascii?Q?mNBbiCNo8PD/KfJCUm+R2YsaoRtd7NBxajlblv+VfkFPZPqm2zabB5QgPDF3?=
 =?us-ascii?Q?RGwEX8tHR/0Xlq+iKzkwpWR5M8nAOVpJl0+CBPPMmkhsHLE7XX7o69GqOSys?=
 =?us-ascii?Q?Wy2BCU52ivCC6jGwWOA9FrlojZv27bhnnLNODWHG3lix+pSLMxXOANc7uVOB?=
 =?us-ascii?Q?jbOkIg+hl+Sdww+KGj7r0Szr1AH2llhGCnpDCO1c5CHWcrcmXH7rUwL/EY9f?=
 =?us-ascii?Q?JZfAfftBGPi18EwFBV6hjzZOFGkQu67d0usHxv+xtAWk+cyTc7BQNZ70WSbP?=
 =?us-ascii?Q?bHIbhhvkLjxzYTSitJAe8aWGUinrhmhrJHSewq0lRSQEmQo0SSJjsX0tkHNy?=
 =?us-ascii?Q?Y5gsZO/1tjko/bhw/2S/4JX+VF874zl9CSozZ3UUJ8X45dL91xav7spllPLY?=
 =?us-ascii?Q?MqytVbgNFYQDJoU9WNncSCxHiP+8IBXSDJVNXHMN4MzJcahoG03L6GV602Vy?=
 =?us-ascii?Q?yZkV0k7yWRcO4VJS5zOvhtRWPhUd4aNfYkMbzVNvfvAkTbOmuNlVpS11aB28?=
 =?us-ascii?Q?ss50ncqc4GEEJn7zqPL+1WMuA/+73ZnN66f5AzVtGFWEBVF8XFkI9QMPLZto?=
 =?us-ascii?Q?gP0S1o0Rq0c3R0pGiriTCTW35KVUjS54wjlEOx192SRmFgEuLNj+Vlf4UEnE?=
 =?us-ascii?Q?Lrhz0Zt4cEvohah92s4bU/RW6pgXKgY9+zFMImSOna+vcxwjspP9fsWVFkPj?=
 =?us-ascii?Q?ttRHRKwMvS5RdZKCEerv04y9QqpSfgK8ROv67XzDW8w8KwJrVUz8YVHriGLu?=
 =?us-ascii?Q?egc4a0jP/uOw7NeqG4C8PJp7sl0BC8uqI411LVuPfVyxLzmqN3HNUpJmbqE8?=
 =?us-ascii?Q?3+sFknE0DTJYtuuwq5B40McCySKZXuVPLUc0lqcjnixHl6hf3GiXS5no9acN?=
 =?us-ascii?Q?FYhJFyGytF+7XGhZfV5O3xWBj2piIDKqyNSClprzlDnncMElpVNXevPsN+1q?=
 =?us-ascii?Q?6QdrPmVP44BLV1xEcf4e+mkrXBfKk25gH8j9gqFgr+kk1KeVwVmqkw42whlr?=
 =?us-ascii?Q?iBhTpS+6mmDMjKebnr0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa588c3-d2f2-474f-1e72-08dbe459f24a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 15:05:17.1148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DeklATV38MJhOdBthahSp1jcZeHMNIzn6hVt7cNeYtp+hDyqeGJc5/tft1da6rn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4921
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

Reviewed-by: Samir Dhume <samir.dhume@amd.com>

-----Original Message-----
From: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Sent: Friday, November 10, 2023 5:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Dhume, Samir <Samir.Dhume@amd.com>; Lu, Victor Cheng Chi (Victor) <Vict=
orChengChi.Lu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Do not program VF copy regs in mmhub v1.8 u=
nder SRIOV (v2)

MC_VM_AGP_* registers should not be programmed by guest driver.

v2: move early return outside of loop

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index ea142611be1c..9b0146732e13 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -130,6 +130,9 @@ static void mmhub_v1_8_init_system_aperture_regs(struct=
 amdgpu_device *adev)
        uint64_t value;
        int i;

+       if (amdgpu_sriov_vf(adev))
+               return;
+
        inst_mask =3D adev->aid_mask;
        for_each_inst(i, inst_mask) {
                /* Program the AGP BAR */
@@ -139,9 +142,6 @@ static void mmhub_v1_8_init_system_aperture_regs(struct=
 amdgpu_device *adev)
                WREG32_SOC15(MMHUB, i, regMC_VM_AGP_TOP,
                             adev->gmc.agp_end >> 24);

-               if (amdgpu_sriov_vf(adev))
-                       return;
-
                /* Program the system aperture low logical page number. */
                WREG32_SOC15(MMHUB, i, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
                        min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18)=
;
--
2.34.1

