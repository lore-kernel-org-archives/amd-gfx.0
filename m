Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C9BC001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 14:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F8E910E089;
	Wed, 16 Aug 2023 14:10:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A347C10E089
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 14:10:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzsCFnYxRsC2pP4LY67+yyWFURqP/8Z37uoejxJLooX7XmQ2kPYqHcrllVHgFeC9GSyqAHr1zVt+AzZ5eANyZdMwHqxGa6vDqTGaT7MPZJ2veJ/5nY6pSnq9LMpDLRYrDWqO+fvkp5LJYwzWBBpHlo1VtTBNg+mJcod5gY75EIi4Rnq1xYZvvf4B+VaX4fuJLGbj7o7zstJG7c942m9lNIt2sfBLyBKwknIdlchglbXRNScQYAO6/cE2z/HSa1HIMMkImg4MVoDUYiNU+B1Iqr79e1/ThoBgm3uEYXYKYUlFwzAlioZJEyq/IGQOwjf5k2MPS0hmlu2jIMAksGcmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPMBiM6JQwL7Q7zibMjh2LTtSzPRUXSn+Q/pKwyvx+Q=;
 b=jHSKKmdRzVR5H+BRVHVQxpXjQJDlUY250pOjYJhLWAV1iJ5+1W2BlA7qiHLsdNPGbLWRHOF6n36TtvdDQp+3V80wHp4Qd1I4msQ0BLfU4n36Ep2UQJvAW9O5Vz0PklB6x9yazaPm/I7JNalD9UD1N5HAeZ+xave973cyiqvAZALH3luV0UeP4Qje5IwV327kIUQrJ8Ges5Y+rq9TdIBLlO/AdvkwNBOTSLO+PSe4is+e0Jk5jQTw0fsJUOf0iGzWlQFV40g+OFgijjNXR2mMvc0PioqkrFzv20YAXnXiohT2dckTan+3QYZ2QTwRpLu7iyuJES7hjAwNMNKw8omKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPMBiM6JQwL7Q7zibMjh2LTtSzPRUXSn+Q/pKwyvx+Q=;
 b=JCId2fumXKy0Msvv1Keu+hzVUutQEoVyjyBNL4SKlFpRrJsdXvPOrge3btZG+0uaFIisEgOxn6Y+9e340DK46X/bZl+37nHKFPgHiD3/7SlLNgw0f9ock4isxq6C7k2IMiuYF7ShfCYP/3U+ohmQym8UTdFP96bNcJXXUr9h0qE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 14:10:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 14:10:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update RAS EEPROM support on smu v13_0_6.
Thread-Topic: [PATCH] drm/amdgpu: Update RAS EEPROM support on smu v13_0_6.
Thread-Index: AQHZ0Ejc0eagInia6023N1SM0a10ta/s9b9w
Date: Wed, 16 Aug 2023 14:10:38 +0000
Message-ID: <BN9PR12MB5257E6C40B58BC2636343DD5FC15A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230816135149.4088467-1-candice.li@amd.com>
In-Reply-To: <20230816135149.4088467-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d4c94034-b896-4b15-add5-1ecb5da9ca16;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-16T14:08:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB9341:EE_
x-ms-office365-filtering-correlation-id: 1d14123e-e112-41a8-4c44-08db9e62914c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m632DDPZI7bFkwX0BDot3GlBIjSoUxGN/6La5Qed8eCXMjyj5KxaZOJuewOBvVudzU4Z2F0B9qiPdlPFLEoywJStEyCPg1kWqjopxMEHzdAKWpctSshdgyDjPKdU0mlRproTiJnszs56RYfXz61Kj3xd1ol25mPPMjHKecTB4zt+OvQjiHyo30yYx9mfF9Nkt+J7Pp6GxKRDYEvTlwbKcdet48yCsApKDufZ8AljbJMRawMWIn3tHCaEyGH15Tmv50LbVVdrVO+i946ko4zcAOoFsogWDo3HKpsxA9h3PS0uJ4A39LPLE+yyhGdniP2beymZ2Olay1Gr1I20P7oEX/QeI8dgiWk/Y6oizG3JrZ/6F0fmpGm7toC/nmXb1JO3y7RTkbgcGu/GVVFKQGmnGqRqoh1D3+AfnKeO1vkH9qrVJffwDo/MxbcBV7VceAGsij8uqn8Nd1V7s+5HUwMjr94gyh/XU3qELpir6+IKCkcnhpuGmf3JgmXvMWmlpX2xeoqp41O7XxwOvfNbDNhnzdiBBB6GAF73EaLeSqT1p6r1QkML8LNqWkoxGMbkwFrqJOSU9hLFu8y1OmtrYEg1h7aU37E0uobu8sOyV3MRDf409p6g3BPMX4A+zMWOux2u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(76116006)(66946007)(64756008)(110136005)(66476007)(66556008)(66446008)(122000001)(41300700001)(52536014)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(2906002)(15650500001)(83380400001)(26005)(55016003)(478600001)(86362001)(9686003)(53546011)(33656002)(7696005)(6506007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G5uWpq6Z3QGteDmo090QOl9gSfo+Qp4ZrHSMjHZcHf50h3nXfVFgQsWF1u/N?=
 =?us-ascii?Q?qicg/Cy5tCVQuZv4FF+w49rfrrHc/9gQz3LxZEX/IMPBcKM81la4EohhIPUv?=
 =?us-ascii?Q?zZ6qYLmCFRSQcMYA6yqgflAcclS5+UrcCcYbzUHgCNTNotJODBcpU8xL0+u6?=
 =?us-ascii?Q?CpnFPTpYBoCUg5itPAOTDMULwNROfPgx/jld4b2imwzFrMV/vrq7QJbrDXxw?=
 =?us-ascii?Q?35/7jROfqhYOPJ7EM0ZvEuEUHgzUq5hiEfEcWWFhNA6bsoCcMtkfuaOpib72?=
 =?us-ascii?Q?hcN4EeNnSU7rhhXtUMP1q3rRUPhfyWMUOQ5FivIBls5MB7MLxQ9BdgyUqtCu?=
 =?us-ascii?Q?WjfmDJmA7btfzJcmN9YZFIW54fWNt41OcMcL/eIdtSHsqWKMA8xW4/6SUHjq?=
 =?us-ascii?Q?/WI90fY7f9znk9XRXZOeGRv1sEHQ3rHHZH5VqifMjMKz/+fTVhvbpf6Lw77j?=
 =?us-ascii?Q?s9dXebzC1L480WGkgFslU2b55pxkZUbBvxNM58rS3WwVLMFPOqJqFLnoT5OY?=
 =?us-ascii?Q?iNuWRIPilDfQgItQcgWk3nws2HNZTlcfIqDCoGVhUcTEpLa0ZTVm5RZetVaQ?=
 =?us-ascii?Q?DDSI+07YaVv+wHpPVoG7aCt2HK/57F4ijgrxwI2BlNPKoO50TzJ+5cpBpGOu?=
 =?us-ascii?Q?Ov5epUepChtEt+MeuY+HxBeWTYuUuRaWJd+aFvr+lGB50tVQxrzx5+XzCW4K?=
 =?us-ascii?Q?tJgtVDvURe8f9+lkN8o3yBXfpJyQ+8NKqyffWN9jIwUGPfnYC+cJMKL3DwHt?=
 =?us-ascii?Q?Dqz48aWYdb3+IVeot+ddoEFaCIiBmVhEDaXIQI3lOckgM8wKi+UZ6VTRMvnd?=
 =?us-ascii?Q?Y/7j3CDcRmHs3E6unq6ssgsg45NpFv5XA46FgMkatoIhHi4ctE8OGnWPWNAw?=
 =?us-ascii?Q?QnVz5BBpMsvHjnc6g+h0tNGVtUSp4gz1un6PPlTBtrg3x4dfqiBEx0wAmo8f?=
 =?us-ascii?Q?y8cC+VHwVkdpESNh1hc/cYOmvGTnsoYWAeCmhgviGLpX7H30C3EsFa+SrPEg?=
 =?us-ascii?Q?9GuwAn0d07s71W8XQhldA6oKAlLYw9NPhGGPGqlUFfSBkWSVSd40ueOlQ1oT?=
 =?us-ascii?Q?vj4JGsWxJqfTCfYl8Jy2jNfMXfsz3qvF88Osw2uF62yPzuXstRgXq+O8TWTW?=
 =?us-ascii?Q?BVNyZhSqsS+5Ok3lXANDB/pL5JewlK+npH9H9y62iLA0SQiDPDVKqKJRmoOE?=
 =?us-ascii?Q?88GRQ1MhYvs0sUfz4vn9dFnRIMZ/7ZcfUcvZwMF9/xWhFf0d0fs2mEUv5Zp7?=
 =?us-ascii?Q?Jgwp7DPHosFDqobBWhRGuQW2p610rDdvvrDtlTFaAcNbcVUuqDN16CcL1FD1?=
 =?us-ascii?Q?mVXn6vrhNIgqTMyBM67MLRzXdV2M+XmSA1OzkZLIEefyKc3OTDbDNYizw+6K?=
 =?us-ascii?Q?DqdQgsdfm/i4sVi/AW467+yFT9Mzib3Htmx0mWA8PP6ZhdY66ESUAKrmZiEC?=
 =?us-ascii?Q?d72A4O8cOXZilXz9MRtAGRLTrqqphDjorKpyEDuj5PMZxVX1Ua3wHj/0rYcD?=
 =?us-ascii?Q?JZNGEnft29ILg1geS6FvIaILzoGOBcXMP5fZaqBQtXaGvkOgRbBJXUWxsINA?=
 =?us-ascii?Q?WEhH0Oaz9mNwaAU+5x/E6x/P/uM/CHeUCln0bKI3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d14123e-e112-41a8-4c44-08db9e62914c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 14:10:38.4628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAp+G8L3agRXYUBPoFqVEO+GkAYHTC6hcz0dPQ3a2VNV7LsXj38W/QWL4KIn1SoqyyIrDSMYVwkcMzPCe4ibdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, August 16, 2023 21:52
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS EEPROM support on smu v13_0_6.

RAS EEPROM device is only supported on dGPU platform for smu v13_0_6.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 4764d2171f92e9..595d5e535aca63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -158,9 +158,10 @@ static bool __is_ras_eeprom_supported(struct amdgpu_de=
vice *adev)
        case IP_VERSION(11, 0, 7): /* Sienna cichlid */
        case IP_VERSION(13, 0, 0):
        case IP_VERSION(13, 0, 2): /* Aldebaran */
-       case IP_VERSION(13, 0, 6):
        case IP_VERSION(13, 0, 10):
                return true;
+       case IP_VERSION(13, 0, 6):
+               return (adev->gmc.is_app_apu) ? false : true;
        default:
                return false;
        }
--
2.25.1

