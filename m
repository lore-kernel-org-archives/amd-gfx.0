Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585A8C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 10:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD3B10E763;
	Thu, 18 Jan 2024 10:18:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BD510E763
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 10:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9kMpRGb8cjkj81Wz7YNTiojD12ts0N+etJ9TXXUh5CRVlEUnYp19I4f7Fw8/SjhOmnzPrS7xhkBfvDhWEm/A8Ra82hsLS6zlmZbaGooPHrG0UBjVvIGTw/lHYLrOetpz8N4xe2RrVzJZdUEGu9KVoOeAMC6YuTVYXxxewNNOg/b9RMLinC3e1hF5RMFYlC0mMiv9Ec0j+cUq4iSyoK3nX0RpRaw+nur/IYF9zCrNhc8ZuLJ/J1oh/Dl5TD3y0wCW7EbsVE2iP9DMRE030Lla5IY4BnbzC5HDSF1pQz5UH5TTBpyetzEdzabf2MYkGDRrVh6+eVmNWl/abs6XbgtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL5Rlg5Bx/euW1U/HVjsVDbeE3SnU0AgQrYhbh3SDbI=;
 b=noqv4JP9I94MMCV08TOv76nXVjRG8kl97ZXzsyySPV+wEhaZ9sa0WbyE4UZaVCx3VFN6H7z85MYa37aJiwiPBJWWkUbNqRznaxamaHAqecrDZXyWkO8boN2ibmXlNhsX8U1cZOcaf9KRMQw0sQqbG7BlX1U+mMFeKpad6r1QkhWVMMDNSs1DTglFHjZs2WKuLWphnTr62O9EVicJf/quHzkGeEHEMdW+idtP8itV9C7yY34XBVTlHfHlBAe9kFQlu40fXLI0FC5IHAEaD942G2v06S8CYTIoQeRLTjMccwgvsSGEWMch02hJKYdSZEXvrE1a6W94KiVZri5rdfJMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL5Rlg5Bx/euW1U/HVjsVDbeE3SnU0AgQrYhbh3SDbI=;
 b=nPyv0J3oj4iMbRZSTpRPDUHLJrnuXBjWWEnnuYYolapDx+zMxnetZsVAYkAil+Z3qc7IX+oWQz82W2HDq2R7+xZ/6GgNx/c2lpHOD39LXySIvPSJyqFgJMSrSikumpVgU7wheL3SIhzOEEjaPZ8m2JArGgfmfZ9tvQicKsK02GA=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 10:18:32 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::1766:791f:b4a0:5edc]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::1766:791f:b4a0:5edc%5]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 10:18:32 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fetch current power limit from FW
Thread-Topic: [PATCH] drm/amd/pm: Fetch current power limit from FW
Thread-Index: AQHaSe1FvbK6XEzQsUyacbashb/flLDfW3wg
Date: Thu, 18 Jan 2024 10:18:32 +0000
Message-ID: <DS7PR12MB6071E9E7D42FBF436A1532D88E712@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240118090314.155112-1-lijo.lazar@amd.com>
In-Reply-To: <20240118090314.155112-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=403144a9-a39c-45e3-902f-a0ec451940db;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T10:18:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BL3PR12MB6378:EE_
x-ms-office365-filtering-correlation-id: 2dffac41-136c-4041-c1e4-08dc180ed2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYV44UGiMQBMUTahL9MgxQgBi6J4kbTwKo9VnS+1IFES9neWQ9USsWr4ZqIFqC3Hx8Z1/7X0xKkg1hFXdD+wSJly5xauCP8nGXA2UcVnRKAAhbsNgz4OcKXQPqrQacjNwaWs9ksJMjWBnULIVJ6vkjCqCUM/NyZsQgeFXicjoBjeJIjQWvhRweCM9xvbQS4OqbghQjiW91Ayhfhrdftovsmg2GjW6zkCI+RM6414L+cMPuwzU1YwAkjdqcEtwV0L7SwcNWlqdfGdX+dJJ1AJDRhSYAzSO+bWZKx8Yr9WpRBsVSGpGbz/3Z1fiYeX/6gEhPpihKZ6t6eNcqTO9hdoBBwpKxn7Q1/2qN28Ud3m8LsOuh/7KecjvQAl/NrF1KsOLbGcqR7ffyIf1cT+3n7DC15wFw4/36vTLDhQr8lgpj0+l98KXOvyLb/mV58j/k0ojWHoTaqCBWRnoYtAWvsPOE+KCfT5H9G1GjOamCIOYCam2gN7nio6rKxQSaYAotvYzuwdTO0nvVy12GNQI3drxTDeDne9Yy4uxVWsJTAntzBSxQgkNVlnAZT01VOH7bKWyaDhO0HytWy3aX9Fg2+U6FFgEMFTjL5atDd1Os+Zdvv8685OrpXjKHa+mzeOPSAd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8936002)(8676002)(53546011)(52536014)(7696005)(6506007)(4326008)(38070700009)(33656002)(41300700001)(26005)(5660300002)(122000001)(38100700002)(2906002)(86362001)(83380400001)(9686003)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(55016003)(66946007)(76116006)(110136005)(478600001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x0fxEym+e+rsU5KlBFXM8qxHFbbf6luwBYkiIkHrxNlpUJGQHYgW34hZhtWt?=
 =?us-ascii?Q?PAxyq6XH+ML+ydP1pv2np0pUoH/xOepWdQVw6BrbHj66r6RC1xW3LeHuteFI?=
 =?us-ascii?Q?CXtNNCrEQF+lBWuFtBSKXMMRLeRBxhUqGU/BMErPUlyJRzGiFiDYKVf5/MQQ?=
 =?us-ascii?Q?ajTxOfc/GJhUTfkaqCIdZWDdT5YxnsLTZuUvKnegkTNcAJu/myrTuzRSbkNo?=
 =?us-ascii?Q?j6zVWK2/GO14nS9EtxS/JgLRhj4H4qKZQ87Ys//Lk11HdYqbhZbqaM5eYT3i?=
 =?us-ascii?Q?0nH0Vj/60jNd8BvEmQCnRUL0eYN080hXBqc4x/oFXdsCfyaWneSdyu1O/sml?=
 =?us-ascii?Q?LeyxNz+FMiEZzCajPLGAspK5LF9zAR0OiE+ml/9HZ3p5acpsoMiM3JLoUhGY?=
 =?us-ascii?Q?7nHGcxZtv4eE2MCiSiKMBZaPnri000xX/yOYgsZX2ndY0Z2HnZrX1nOWzBNT?=
 =?us-ascii?Q?1qrdnSHJ06OTstOwxvc/2WCLGx+frSLXTIeIO0jI/1tMhxLzsmIO8R4DHlsv?=
 =?us-ascii?Q?rY/152okqvKhT4E+lfNzhoE3ptEfv/HZ3PsTs3TqxhXrtiqolhaGkZMPNQY9?=
 =?us-ascii?Q?HSfZVrfLq52vT3191rdKvysDYLHWIgA3JKnF/vUBY1wDSoIfSkwBpQBkCiG3?=
 =?us-ascii?Q?NyCCqPhV8QdKdwjPinEwn8JmoNrQYeqS74xc3viaduHLSjeRSvQgaElUeFR/?=
 =?us-ascii?Q?3ZInM+OCHwhhICJ1jCk0DfuxtKKuJE5APBiNLGXwhPN1XVN8ZLX3vurABNK7?=
 =?us-ascii?Q?U8TmZSfOX9ij093+k1WDyBNU7MAlFWgRgbUJDjSzG/lDLJ+ALS8yH/OFb8NK?=
 =?us-ascii?Q?5+/CLhELK4nxILCXDHMg8TEOl0DfU4at2ax+0uc4rm2cBGN0oyeJ7B7Cz2HL?=
 =?us-ascii?Q?uJOBvtdp0eAO0QMbN7J/snkTPacHnrAvbZwVBJL/5uG1q0xtKax2OIVsPD8p?=
 =?us-ascii?Q?D1UCM2OW9BbwpBz4nAK/kIPD9y0eCpXyWIGn7sZe2ByOpbhPbGan1Fn5LrIJ?=
 =?us-ascii?Q?G7A5Jz6OhqPKiBSx6kE+8lMZpY3EMVXxy9i81nwydg4A7/vxplMoVbVr62H8?=
 =?us-ascii?Q?ROY2FUIpze90pVjH6TmLds17hQFv5vRjR/Z1LC3ecIAFlbKZ4V4gB5PnpoFo?=
 =?us-ascii?Q?eijSBhL23cJ3+w5cnBBoGvzRnFDQOLCQ7V/HeBzz/hdFvJF1eeeIXno1ea1h?=
 =?us-ascii?Q?CoBnY2yPTikFHcPLc2B4hPwID94wuBUizlbV9zC+aIU/lgdNMY9wZCxs1ZUN?=
 =?us-ascii?Q?MYTmtzNx6gyofNYrnfk38qnrD9tk6LmY86Q7IG+8113nJhGozYyDdLK04Fan?=
 =?us-ascii?Q?Jd0MaQXGC7XSe4VeGpxXHVDueqF7SS5DktAUs0SAfH+47FSm9Hlc1tqmZP/0?=
 =?us-ascii?Q?55fx8ALjOllendpIDmOHT5W5qgXYLSy3URZzE89MtMGPTLpsSjOvFD6yGtVZ?=
 =?us-ascii?Q?EAr7sefW8tfDsdvWM+0Z9mGgQHTXtbfLNkS+r0i9+jucSGBpxMAyQXOsCu9K?=
 =?us-ascii?Q?2uhStyxH6rFyG78Bq8bdxB7AAr524DLBtlIsOAYB1UroVo4/9gsbW56xsKle?=
 =?us-ascii?Q?Mya6GmsWtTtdYUKWYnM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dffac41-136c-4041-c1e4-08dc180ed2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 10:18:32.2365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R972JRzHbd2/e0Qo2MgKH0PfjV2O3DbxyAP15KJuK8u+Un+KMgHHLJ0b3mTspSnYwxYaYcGB+mf21qqmT3hPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, January 18, 2024 2:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fetch current power limit from FW

Power limit of SMUv13.0.6 SOCs can be updated by out-of-band ways. Fetch th=
e limit from firmware instead of using cached values.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index c16703868e5c..88cacb4770e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2710,6 +2710,7 @@ int smu_get_power_limit(void *handle,
                case SMU_PPT_LIMIT_CURRENT:
                        switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
                        case IP_VERSION(13, 0, 2):
+                       case IP_VERSION(13, 0, 6):
                        case IP_VERSION(11, 0, 7):
                        case IP_VERSION(11, 0, 11):
                        case IP_VERSION(11, 0, 12):
--
2.25.1

