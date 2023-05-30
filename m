Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F399C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 01:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93A5A10E0AB;
	Tue, 30 May 2023 01:53:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F46510E0AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 01:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2BnEstTqPnZCn7iMPdL9pWsfM+2HcIeMTYxlXbuPMSr/3Su7CuKiDfpNuY695CODq9LnKwQbbeSjeiwXrO++5xCqNkK0RopjPYoh2OcQNgL8QOqyJu3AKZhYUnSDZnx1f5AyM1fxCx9PAYnkASRHoqN6sy1jeuFofcaNGX5ZFTY+camSS13HWtAmBlrbv3WNQMPuGGpIifmOZeYVFBUPvAYZLOF5YO3/jPQ/vORMCCJf+3Iy6hVdknpGko76CJw6uUj+PnmusU9ND+QCLCjGZpTaP1Yo9cXQc8bJXK3YGim41imlnxZLjwdwDkstLycVuU8GZX38SNwTh3AY6qz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW8/OHRByyUazmrWtrtP64Jn5haGFkTWMBla04CWeTo=;
 b=G65C1Dlq2QAwJambiYCoqiCikHOZq4tdgRcGye4PeWHQLmYifW9KMo73IRw2//Gs55hu+vNr5ffTlZUeducd5H/SLv5ImU4Yz3g14raPNeizDP9yjIBRFRjAUPa1nwXe0AAJYdtzdRiQ+WKCgWxZrmPsrvmBpbdY4QThwGHB3apGNcjApOoGEJOda7zp7Z95XEguSUaCjnVZS42Rg1MnO6jwz/m96s1zJjRVyDJWZPIChaNwsKdDpSzaKui71jKiITSpBOclHbmLcQgzVJOWjL9U5nsqlNVInazTC34ivZ/rM1OZmgg2zkHygbAL2Hwj+gQ9ec2A6ypos1vnZfUA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iW8/OHRByyUazmrWtrtP64Jn5haGFkTWMBla04CWeTo=;
 b=ZaxTmC1f9GcswGriAHN86fzJ0Lkxc3yoBqBEpYV0J4zgHqsG9WLw+L6XZDW/JCSrUoIlH0uY1I9g/Tj+uLlYqZ58cszkAUaMx5ZUvAN9aWbf/yEqtUqeH9fMCNOlsZBDKolEeMTPBMNG6fJFxkwvKwobNzsm5XJzO+I1nGfKAkg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 01:53:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9c90:4cbc:7d12:fb99%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 01:53:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix MEC pipe interrupt enablement
Thread-Topic: [PATCH] drm/amdkfd: Fix MEC pipe interrupt enablement
Thread-Index: AQHZkjW9nimGNN5la0G6M+UoBTyxT69yDm+w
Date: Tue, 30 May 2023 01:53:05 +0000
Message-ID: <BN9PR12MB52577FF80A3BC7B1BE908FE6FC4B9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230529135813.566730-1-lijo.lazar@amd.com>
In-Reply-To: <20230529135813.566730-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8abe5449-a8c0-49ed-a171-6844a20f05ca;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-30T01:52:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB7551:EE_
x-ms-office365-filtering-correlation-id: 17bf62f7-18c2-48da-babf-08db60b09c53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1YZ/J4MUa2Sle35JZWrQuUfXo4S4DjI6rGR5StbqJHqv2ntT/8ly5Q9VPp3bOXbYMfWztWN6KBc8O1rRZ39Dq8hgmGjzJEej4k+WgxMyrKhUu2s3U61ex4j3EnX7ECRFPOeB/7C2Cju+4NdYW5cvIArrWnhM0+9UUqBQrraIIbAwW+x1n9Dd+lRCGTKkXb7FkSY1anZPg7JvHO46/L36EafQKYHQ168Th9evH4uYOCeiZWgohbDdO7IGmGmE3tumuLNINWjmkoua6BnJuSVT1eBIcqAYG89cxoFS37KfxmBe7QUsIhtaOsjIG5k8Vcb+cqcNVhKDLQ55wVxUmt+1adZ9z9n5M8VQWmSJZJmRe8Td+ASaN8u6V9lEDEFHrwmyOJYWqPaE7surq0n3WTs05qZLE73T6w0cEbM0+FmUxggZiKE6KLS8YFJEMVlV3kLZsElPwb/QWQHcTV8kTJyJcoBkAtXg4vjIGLTUfRvGlyBMdDPlu/DMKKNrchGeUlPyTePUw8RrC4AQhkJ66+eIgf6U/43yqnqPDQvbY/LupamgYB1JX6rI45ZdkzrEFHSnr3B6kc1SXHN76uNpbj4kIdQ8rgxgHSNbCiFxHmOhzFD8mNrdRgW/xiOyQXYAl2b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(83380400001)(86362001)(33656002)(71200400001)(5660300002)(66556008)(316002)(66446008)(66476007)(66946007)(64756008)(76116006)(38070700005)(52536014)(4326008)(122000001)(8676002)(8936002)(41300700001)(38100700002)(7696005)(55016003)(53546011)(110136005)(54906003)(2906002)(6506007)(9686003)(186003)(478600001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QtzyO7efuTZESZdlTWjmx46Scu17iuemooOjQhe0DgCGMS3C3ZHfKWSR2ABo?=
 =?us-ascii?Q?MIs028QUhtFYvgj65qoyEFNinN3sPL/6iTF+KqvEj42k1QbC847Maapf62vZ?=
 =?us-ascii?Q?Ha6Qt4MVmPNdjyLinPIvJrWT+1YXsJxHqBIfmyBGqPEiaZ8dpWzBzg1SDgrv?=
 =?us-ascii?Q?hLaD06sAoSEmaBLEfjEjzo1Odcumj1XaxWHiv5SqeRdstVn/Ywd2Fa9Qgu9J?=
 =?us-ascii?Q?/+Q6BvgGaF20HA75wiZadqkYJNYHmDwGygaYTBZRJ1fihBMLusw/T3Y82qD6?=
 =?us-ascii?Q?hZi3h/VD1haUvJikbkdARGdaDIaCeJKniMLbn6Br5zoEzoP1T2Zik6bzf55G?=
 =?us-ascii?Q?q0HS/7LMM3HqGe1OMEEDPR2fKyKMe7In/rgnsMA7QNuErwW5X1GtrmPtEVpW?=
 =?us-ascii?Q?nSgKXlpTJVhiIbebpTmqPwC7wrNnbsnZu0TzVXsS+ayQiLdondRvitgm5ouO?=
 =?us-ascii?Q?uAHlolu3/eiR7b7tdaeBj6FLRzcTDSRzz26DF+mAHoAA9eAtTRPgqCWY5s0S?=
 =?us-ascii?Q?vuSg0xrElBzjl4cVO95hcgaljak0d8W4bOJAiyUXL8pmWEB+V4JPjhNmscoA?=
 =?us-ascii?Q?LIRIc09o12ESizjt6AnAxQAVgPEGA7fmf0BamqVRNFgrLvEAsJvj7B3fQbcJ?=
 =?us-ascii?Q?zcJnLLJbCvaid1OnoA76QepszLkZxPWCzfnPCvYqfuhXO9fx4vTAqX5w8ue4?=
 =?us-ascii?Q?PMS2Zw3LCLaCqUpLI01mDj+cWq74kwrhzt8Elf1AREdgyif0Kxaeq/PspFjQ?=
 =?us-ascii?Q?fZK599Jy3ZdqN46HFmXSTQP2M8Xwt+12q4fhIpEWMVNgywVscM6sZjhn7BtQ?=
 =?us-ascii?Q?DguIa8kDKOZyb6p63nljuY/++1lNaBb0wKfyELB1+OaL4xw0Mop7fnEk/aCK?=
 =?us-ascii?Q?ROAOr64iY4GilyFX9l59vitOzg4Bnt//wLN3ULpXaUxYOaCMldDrwApSxxyI?=
 =?us-ascii?Q?w3E5KZgxmtm557w8tUXDT0lWJo1X3xGl2knMo5JEmgM5Sm5RsXZ1dM7if2+a?=
 =?us-ascii?Q?XyK5wo8jLjWMTzTDN18AvzgUi4KsS7H0vQoLZdLM5k9nVx8Xsx2fkDRoH72S?=
 =?us-ascii?Q?yRCAxlMjPJvQhkQ6AdHIc9xhntKaVc+ZYbSsb2CqWd4tqoDj+i/ecSbeW0Rl?=
 =?us-ascii?Q?pyBiizn4bHgvmEgKOkRifyl9UsYpH9HXbxLkRjhwJ5Jcs80DZenrPoknLxJa?=
 =?us-ascii?Q?YjKueOsMTseHhtRYnRV4f9w5NMfmRc08EC4xws0xU/toGN6smbZvjJeN3Yd7?=
 =?us-ascii?Q?AL6BbZJFAX/vysw5edYHvTh79jBR+aa3W1oUv/HhjkFgSAc4LPKUfZnwYu4c?=
 =?us-ascii?Q?9/cYaP0Viq1ejFF+3MLR9wbpON3r+NTlomU2zI/H4ivv03kL4/v2wHMDEeae?=
 =?us-ascii?Q?L6dFs4VpT2Egm/09sHe/oENGf+VR8plGXbhC3eA9HA9HIOmHHDfgERsH9dCy?=
 =?us-ascii?Q?Djws2/1w9EW9az+wGzq83cMwyvZ2qzq69lHa1JzjdiCHj2JuGcmq7b3Wdsku?=
 =?us-ascii?Q?ncB0NNjNifj4ihrjDLHDLF/0RudEKgSRvScCZ2B510+hKI9hOkOabaVXsE50?=
 =?us-ascii?Q?NQBxXNnOV2mRLGaE1d0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bf62f7-18c2-48da-babf-08db60b09c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 01:53:05.6220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxjlAjAY+3/RJ8WLDgQ82pDzBDfzMWqHFAETjPDftcCTnxM/yDm3vcw/b95gB3PsBa+n0a7KnfXvIPFO+xqfAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Joshi,
 Mukul" <Mukul.Joshi@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, May 29, 2023 21:58
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Jos=
hi@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix MEC pipe interrupt enablement

for_each_inst modifies xcc_mask and therefore the loop doesn't initialize p=
roperly interrupts on all pipes. Keep looping through xcc as the outer loop=
 to fix this issue.

Fixes: 7b04c90a48b1 ("drm/amdkfd: Use xcc mask for identifying xcc")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 493b4b66f180..80cddb46657f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1274,11 +1274,12 @@ static void init_interrupts(struct device_queue_man=
ager *dqm)
        uint32_t xcc_mask =3D dqm->dev->xcc_mask;
        unsigned int i, xcc_id;

-       for (i =3D 0 ; i < get_pipes_per_mec(dqm) ; i++) {
-               if (is_pipe_enabled(dqm, 0, i)) {
-                       for_each_inst(xcc_id, xcc_mask)
+       for_each_inst(xcc_id, xcc_mask) {
+               for (i =3D 0 ; i < get_pipes_per_mec(dqm) ; i++) {
+                       if (is_pipe_enabled(dqm, 0, i)) {
                                dqm->dev->kfd2kgd->init_interrupts(
                                        dqm->dev->adev, i, xcc_id);
+                       }
                }
        }
 }
--
2.25.1

