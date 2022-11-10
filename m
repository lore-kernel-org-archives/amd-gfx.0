Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A0AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 03:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DA610E655;
	Thu, 10 Nov 2022 03:02:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C665E10E64B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 03:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKnWopLekqyK9a11701hOhZi7cQfuDuFeWLCXEuXOZced0LHhwcY8XfOYS213zN2AvTDjece2MvqBOZ9zWUde+dKSQT4TkzSxEPgfQgm6eVkmlP1/KW7pF7r+OqGsNHwFnBOp9wyFVRQIj0Tggl0mXHJjV361YQsYoJB/Q4JmE7VWNq04/Q5bj60JgrkybpV8iCUPCzZX12VAraHB+XgQizKXsuR6yLttSHkvCuQ/g+6wPI96rZMevFDCjIJyE8bvRS9GbBdFiaSIEGzdx2B5+dgof4b4Mwscem/wIVTmJurJP9251RzfGP0ZA3MIEVCFUKUfQTIGKXTePwes3+5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRXNsiWThpQxSSs4v88urc35wXpGp+KnZwAtEfn+XlY=;
 b=QlDl4xcienODnTJ/f+P3wXDq7TQRQvgnY7hF+1w14G9r8hLPVNrTROKCg2GtB2hgLxhir/TVOT3Mg7dbvVW55WnCvmTC8pSyYzBtoHZ350e08IesASNVAoCytkwSQFO5fImvJSJjzndq5JAaUT+z7q3X5JlT36RQ/d/RQWTYvHETDzomoVeaDQRnGkazkSU2mgOupIpvP7vLUKjJFG06NM68/xqaCPYACDyZcUByuBbZ1Y08So1sHnvzRrUHUWrmy9P2xsNmoqkCQEmRjKHI4L/g+LC2jik13iSWj3l1WJbIyvto5txCZVYEFKJIdMRV6w33FYgd2z2AF2reJKSZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRXNsiWThpQxSSs4v88urc35wXpGp+KnZwAtEfn+XlY=;
 b=W84UOgMxlqAny1E0o3f9w/jgSAJ/A150Iqgj1nTr/LoY9E0cjBOXuhBAL1tMsWPbYVrxV6Ke0i2hlavVFi6a/C4eLwM+ij4acBmrdjk6Zz+f8MltnWchN4+J+E41n22JaoSC9uGryvRkzVuhr3OVRKNrRZ1Ydsro8CE5wdTmG8o=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB5013.namprd12.prod.outlook.com (2603:10b6:a03:1dc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 03:02:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 03:02:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: skip disabling all smu features on
 smu_v13_0_10 in suspend
Thread-Topic: [PATCH] drm/amd/pm: skip disabling all smu features on
 smu_v13_0_10 in suspend
Thread-Index: AQHY9K/dTaxpX1biRUWaWipkMLsF7q43eFFQ
Date: Thu, 10 Nov 2022 03:02:40 +0000
Message-ID: <BN9PR12MB525708FABAC06F348BE82355FC019@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221110025442.63642-1-kenneth.feng@amd.com>
In-Reply-To: <20221110025442.63642-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-10T03:02:36Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ae8b97dc-ffab-4078-a6c7-a850c93df162;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB5013:EE_
x-ms-office365-filtering-correlation-id: bb616d6c-ef14-43f5-6632-08dac2c807a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDFbU0SuCNtho8LzIFyaOSV5O+8lxS1n01pHDwUA5gH0lCUjudIG34Ow4zUWYdnbVa4hFaGCe03hmErox9RXjNgx7bH4Py16Bt/8sq24bUH3fH4F0LlSAA3u43UO13jDPvaO9ZwNYx/JGJMY1Acxa85yyjML8+P7S+7LIIeVY8OvWQg+a1f3yUq0Wnumur3eYT6rjyqs2GsuWfn6JjzeEuw5OcnPL6pQB4xbi7Awd9xbp2RzmjV7BuAX2cVGRnuClybPBFf0+II9iCSJUIj+H1Ah/3JC6h1YzY3Sj24YdL65s8uS+tGGRNbVuPZcOhRzE/JMF96r9xibs1M0OB5VwfsGDlRINSzC30mIDwcsly9h49tZCjpjn1MQBZmnIES5W8bxATx5HLkVOHBZ99WkbCihskiQVy+xEuBVQh/yeTrkz73aROpfLXO0brjMHYO6iag/lCkqtTWCfuq7rkL/GT90N/4YMA8oJJ9sqGw2eGoF0Z0pmcY8DxJ9s/UZkAyTni4MOsm7KxRS31FgDWNdxeSW+RGrLNPBeY1Odj3li1a0HiwrtFV4l/Sjl/V5pr0h/a4ytMOvyNcrHXDDi9tzk8rkiNrff08FtkMaZX5K7NSiDovaIrFPw7Akq5YMjZooIp6oJ3rD3pSdzxRyxvJ3uPJgxfZ31Vg0kA3AoJixvfEFTZRvxzWi4GGBwkmAw+QmnD3LaemEomOPbPGZU1WIv2MZJwrEdTNqaf9+CXJEAleNjAl/p+gfvB16lv44ybPW+CngLMlKVJR+OhqAbJneZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(55016003)(33656002)(71200400001)(52536014)(38100700002)(38070700005)(86362001)(4326008)(8676002)(5660300002)(41300700001)(8936002)(122000001)(316002)(64756008)(66946007)(76116006)(66446008)(66476007)(66556008)(9686003)(4744005)(186003)(2906002)(110136005)(53546011)(7696005)(15650500001)(83380400001)(6506007)(26005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PQYNbT+rzQYpjQAYE6Qevq6bAGwlGza55OQZoYo51W4COTRaPXIPQRzcyNHB?=
 =?us-ascii?Q?SsjfUTonNEom6f3oebW2q+o5C9/netqVeRjgRsaR1OcwxHFIOManwA8AI6yT?=
 =?us-ascii?Q?TpT8NV4jtD/01If2d2WUb3E2sRb+/vOPP0KsT8FnY+k2dbE8MtLvqZjEVrd8?=
 =?us-ascii?Q?tl6yqOc7hPLLg5/Gl8Ioy26PmhG7pUS6SuQ467djEwmtbBJdGATrgxLOKrY7?=
 =?us-ascii?Q?ukvktAdbrfvZ0Jd6MmFo6OTbWpl/IlGAfYXs/1veTaI3udlw5+AGgVxYGBCL?=
 =?us-ascii?Q?40dLpdIQdD8M5ncIzmLoCsQRt0vdkvP8XCgsspArCtHXB5lOOl0x+KcTuCkR?=
 =?us-ascii?Q?jpqaPorsdyA1B+iZwefntVrTKubI3StgFYAFZKX23rld9CA5roP6I+rqk31M?=
 =?us-ascii?Q?zFIDPs3L7eWtTei5VNY2VVTOmxmlrqZw4hfBBUPcBjfLfrIk+ZGN7b7HmTgk?=
 =?us-ascii?Q?LnEuOw1GLx9aV/Cx6hEu0DzLNLPohDK2LEymOuefmgm1SzpvbnzZGNyH8P2k?=
 =?us-ascii?Q?CfNEEi/T+fXwitAyU+k8S97uUUFTElFQgkvT1KwwCyXkY0MY57hyoV0k4gHS?=
 =?us-ascii?Q?dTmt3+39kCuQyUT9QDrhvdsWTrXtHGE4fNQt1njKHv0f815LFxkq9pnKto22?=
 =?us-ascii?Q?aBEu+RxYX9StH3XWniE5OjY9+MOmKuJZIWfJbiZdhUTKKkjBAGrCWCvG54xY?=
 =?us-ascii?Q?DvHse1yNyQLMCO4emAx4vHZ+PC7Zv8aZjnOTyKRHmf42TFoTjpkxZMT6vYld?=
 =?us-ascii?Q?epxrQ6OxbqjBNNdIgyEwwFph3leJOKDF++0cwxQX94RtSoWWJBdtxTORW6u2?=
 =?us-ascii?Q?YtnqIiQe/sKOFfVTwOx/vPtRoB66Ve/2f/LEhZE3k8nvR0MVj/xEi2ZwUuFp?=
 =?us-ascii?Q?781QTFw47Id6oDm0ayxNvbi3CqdRWoRa90xsc7sTGpKoE0iABx50/b7rqQXy?=
 =?us-ascii?Q?L5m81bT1khcdV1k4cHElVQPX09DUeIWWbj/2trLxiyla3vQkE6cKVAijJkE5?=
 =?us-ascii?Q?PjDMMGbiD4Sbn10bBaZtFzZtTsJd8fN0sqSKMvysxDHS4CorqmtiE1nKORbt?=
 =?us-ascii?Q?YHC/R2h97y4Ezea0FGXVaUPQkUxWpJqK3LoRyuRsSQJ4Ou+Z5cVpiWokwva0?=
 =?us-ascii?Q?wNFjEtj0E/0nbCaxZz9SNyVnVkR65hYGA8XOxpEY8W8aISTXlyJIHaEpubEf?=
 =?us-ascii?Q?0T8qZggEgsq/8vXH3nYkAymiwJX/rVOdRQMv3tD5Ftv/+aNS3SZiAOdU0IJq?=
 =?us-ascii?Q?MQTyzqMqKn4Ag3F5640jMMqWbBaR+avJ2LUrq0CdkSOmDrlp04KW6gSsGc1d?=
 =?us-ascii?Q?navDU6JTWfj9UZyqUAYS4nxoryj3ItA3aLUY8paalXUWMQc3KJEQXm5fTXWz?=
 =?us-ascii?Q?xNIzMxH1itVBFK0PoCLhE43yi/8m+iz0rhDVz0nJs2fLI2VQ5mTLUyVaAbvH?=
 =?us-ascii?Q?rFBVeh1FiW91tAHQp9kwAc9CFCBv7G3Aaajr65a9tbtajO0zcFIzEAKaoEfi?=
 =?us-ascii?Q?U/4qrS1oSLj6/Eckq/Rz781UJrqzTQuUvKJH5sGL/ffV3QQe1yj765TFBAMs?=
 =?us-ascii?Q?AyDKFx7fjISAfT4OjVwC8FD+scgHnAbU2hi1AIpH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb616d6c-ef14-43f5-6632-08dac2c807a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 03:02:40.2987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkxAZVGCgVa86use4qiHi4/uOqlzzgT14PG2BaUbpnRnTFTmqPxKY56JaXEsqkpEZfWTm0NU+qRokAd0tY1vMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5013
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Thursday, November 10, 2022 10:55
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: skip disabling all smu features on smu_v13_0_1=
0 in suspend

skip disabling all smu features on smu_v13_0_10 in suspend

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 4fe75dd2b329..320cfce1fef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1449,6 +1449,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
+	case IP_VERSION(13, 0, 10):
 		return 0;
 	default:
 		break;
--=20
2.25.1
