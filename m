Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2280AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 09:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9FE10E71A;
	Tue, 22 Feb 2022 09:13:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BD510E71A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 09:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL2A9MRLQ03veOFFNrmpfFAi09smPFLcD20MJr3YShnr+jTHcff718O8pTh0ylpurFZkC7ZW+2rOgGys4caZ5oz8VIeghioiPNKhcBLvQ3HPRnVI+DLDhMhEvVOnO2o4QtaDDowEpAgP6ZJMU49Q5QFNScu5iCimXBBaHD9XlR8PVjNY9VoyzMc//RzZ3Kp7N5oZF5tVX4WqF0UFWmJRva33/kD+TP7pDmExbnrRKHozu0PRWs7oBDlLlBpSts6+N4oWKTJECCsh+JTEvt4TWlDQco4aqqJGn5/lCmqRDtz9H9zAq4MXSiYY+n/SDDCYzJJiP/du1r57OuOusdkf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzlPDtvuDsszDr35SSGVCnCcj54Yd9MT18g452Eim9E=;
 b=RYexuIufhekVXN01l9axgTk1ln9RSePc2fbroteE3NiCfXPrrD1jQn6pa6pb4vrG5D7zcZjO/AWm+BKmwFyaVxjIgqqsBB5cDKkFIpae7PWHJa0fmBdJjSEDVG34oZRsOFidYXI0vNdyqqcF88OlAI0opJbW3UFBq6DpIebQp3y0lyX3+IUEr7CarzamnSinepNWz4CtTU6H87QprGJpMIuBJMDjPNiVebqJsY74Fi7MxjYEVcbEjQkdMtgxIDnj6PSSNcAbFNPA1Sh3ifRr0Y+8kfL/JlQPgDNEY5ao1FV0N9HMjCoTrtvpwrNxuYevirmURWMaw7mF4XLBZPb29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzlPDtvuDsszDr35SSGVCnCcj54Yd9MT18g452Eim9E=;
 b=O2bqZe4xfML6yPjRoA5+RJ/9ZSct1HlAsbqz0Df+VImhZ2UcDjp2fnCSxqGMCazuLHtp8Bj4+4DgyUjEhp4h0oYwariA0kd237qd0wPsKKOr7kus10y5b2uvfULeY66cCD4IOHf5ubo3tfxbRmdtBdTI+Wr3bnK1VKRb7VO6Q/c=
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BYAPR12MB2631.namprd12.prod.outlook.com (2603:10b6:a03:6b::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.26; Tue, 22 Feb 2022 09:13:05 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:13:05 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add mode2 reset support for smu 13.0.5
Thread-Topic: [PATCH] drm/amdgpu: add mode2 reset support for smu 13.0.5
Thread-Index: AQHYJ8X20v/cuytYjkSBJsZSRLtySKyfSSLg
Date: Tue, 22 Feb 2022 09:13:05 +0000
Message-ID: <DM5PR12MB25046548ECCD018AC0A6332EEC3B9@DM5PR12MB2504.namprd12.prod.outlook.com>
References: <20220222082622.862279-1-yifan1.zhang@amd.com>
In-Reply-To: <20220222082622.862279-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-22T09:12:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3a7d2ce0-e4b7-4fd4-9646-8a1ec667802a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-22T09:13:02Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9c791e54-c83d-4ee1-9249-2de262ad6a51
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f88bb85-924c-4357-d768-08d9f5e38941
x-ms-traffictypediagnostic: BYAPR12MB2631:EE_
x-microsoft-antispam-prvs: <BYAPR12MB26318E9A2DF6B148DC611ADFEC3B9@BYAPR12MB2631.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4e1iSlQCt97bupVTyYnAY2A6GssSnXdlNVsv1peG1q/KLDxHx6rsnngzlH6xcdn149VHQeyTbdhluVaCYRt/M8NkvSqNmvqRJZ2nQcZPPvdydXJkTzFp5/jFWGxQ2be+k9KPHHvwLCPzmuqzQUHaQtKANRYMUC8dPv1F6okrrkd/cGb4Xj/BLQ21C4FmBsij2obZJuZ9pHylJNjDwpYviEUPHI11sCchkljbxLv9E4gpuBGeQloH2fwz8snrCbFTN0dzPzbAGdpxh5TgOrM/erZ4qRpZOSLRD8IeZmxJmxiqwkOnEjtOQF1tnqPAjumYjlipDnN2R/W15nCxWHEmn/O9EHScqtl1NR54dAbznxy+OJKXS+aBr3eoudGlSkPqlqXBYueA2VliUUsPNtgH4fXB6jO3fsur5S1fI8zf5QlJTe2zZAgzmtZ0Tq5zq0dSyCnB5pYH0Ttnuzgj2R7M1P0XspBZklxRGlLU6GkN5iyNtmuYCH5vmsIjGsLYlSp24ZnsFwvYAKaWwkGy2MIteJkSlsePnLsG3zaZ1xsOXHCXVDiYuhe8sP6qt2GU2liTBhR7JBbRGF9qQDrY5MWmlwov7jDf3xnvvZVoWWguiRzv2ygmWMRmmIuyzRT+dsHdRzJRTUh0WGCCOYBP7SnL2P1SsLKwHZCP/K5RO+6rx/30vrhIgb9czPMQRDYbTkj4UKSMjA2Kr9BQuWcTdCgkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(5660300002)(6506007)(66476007)(7696005)(110136005)(26005)(66446008)(4744005)(8936002)(52536014)(186003)(316002)(38100700002)(508600001)(66946007)(66556008)(55016003)(8676002)(53546011)(38070700005)(86362001)(64756008)(83380400001)(122000001)(71200400001)(33656002)(2906002)(76116006)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+EXpTJts+40N9NJKv9Gc6NLeKCoO3kWWZ83/Qj52vTkKRKrco04xja8aIrwB?=
 =?us-ascii?Q?ZMiiQcEBUnqNKTSyQk7O969eQqWW7gxdLKkm0jL9bDQMpI9ctZBaIU/Z/+IQ?=
 =?us-ascii?Q?RQ9zWoabrwBQ/4wkFVi+3lR4atlTrldyjLLX0xM+VhiXeFlrAdnKv8sUZ/eR?=
 =?us-ascii?Q?jszOZpMVcWyqn8EsaCNh0mzqC6tuQmFFxQcQCLubGv2W32I4Yk78cxxqO+tt?=
 =?us-ascii?Q?OsPAKl8AfTJ8XInxOer5PfvCdhwcXlBNwcNcEVxk0uhSghtCKvHe3jSq9lwe?=
 =?us-ascii?Q?wgJyK8d5vqaRkLZOBZ2VnWjdSGfv0jRPx8WRamuK+wR1Oizs1tsewxBDg0Je?=
 =?us-ascii?Q?PpHUQkkpIjHmApONlqXkU2lEKPbbDHQGdDt+l23EJgj/2RJToDZ5/pHGGiWf?=
 =?us-ascii?Q?1RtjLAfWlRRiOvnXQsgR6mC8LhzVh4bOlZIZMCI1EIycM/kbYqB27GVMYrC3?=
 =?us-ascii?Q?C5hoGA559oMOgftXKwED34wJXyr7SaQnjX+3o1oVlF+Xp8/8iAZlkM8JWwDg?=
 =?us-ascii?Q?SeMDBoMkm74pgdDeUoWXRBaI9szk2FT8Roin8EIyuU9DlImdDi1f6G0vAHA1?=
 =?us-ascii?Q?2ID+MjR+K9gKhUJuzGNZEiYqX3WF6o2zIJJNoVXKTibGm+LjGy/t/JFwg1LQ?=
 =?us-ascii?Q?h9tMDPsOkEykwzB9nehJPSCskZ9jmtde96ea9gRinLpxneVPgRkZ/X7PCWvx?=
 =?us-ascii?Q?owmgblk5SjYJ1awTuC7I1A8GKEOac+5m5p4p+jMvypN9YrBG9kl+KP9lPcqx?=
 =?us-ascii?Q?fbB+lcjxH+3n9brSv3HXZupr/C+7AIbM/EWrjS49rEA3YMIyYSvqToeoFQPr?=
 =?us-ascii?Q?O3F3BLTJKTmhi9WyimgzcIdDNd4dRMJ4RxhZWrZwEH/w05CxYZ4u/e8AG0ge?=
 =?us-ascii?Q?vJoRzCyCJZ7nqykIBurDAr6sdK8J0VIKiols/3+Kub2ReJIla8dKs5FhQDCH?=
 =?us-ascii?Q?DH3yqA7gzqgB40BiI+IeZ3qkgwilhjWkgDs+qj7biVL8YW6iIBdoPB+yM15m?=
 =?us-ascii?Q?NlScAFzP2o5a2UddoeCA6HbwwIiColLW174uqXwVFE459euWe3FDQm5JIwSD?=
 =?us-ascii?Q?Lq1TY8BCAjKmR+ThtU/diIQhTEgqrslC5tJXDoyXOSNyg6kNNtBrLfU7Jehh?=
 =?us-ascii?Q?cxuRx8GLhM0aH0A5l02U38/1DBkiSywaW9nIb4Q56TyvXQICzX8fME7yqmNM?=
 =?us-ascii?Q?rMFTzoQUkfA2smnQRd4zop17hCqdrNMcPAxH9cJA6+oYHSQ4uwZOYhQiIWQr?=
 =?us-ascii?Q?RBrazjO2X2/kUDe0tc1RT5Q/2D0S9K2/kSsEYOopTyh2322x5vuclg3RdgiA?=
 =?us-ascii?Q?pvzMiXkB6RMgPKjq5XXnrjhRh/njRx9pgNnqOKeI7shPtw3M7CnvWZ7LngKH?=
 =?us-ascii?Q?N3CHSO4+3iYS958CAvjkoa7phPeW/zECC/FgSLorCE+czqKfg8y9L7x1QDmh?=
 =?us-ascii?Q?aFlsF/JBCuRQhthJmNTl7qHpMwelDwvkjjQKZMnvVLUo8zlGASpjlIYEndTt?=
 =?us-ascii?Q?QSCWVhvxR2QsVCPxuilW5TwFVR1s1ZHGNnQuSp79uUPdWDW63xBCFW2YAXkg?=
 =?us-ascii?Q?0yl9mvltyNy69kVRRJLdcgDkiDVgaduArNDJan5iwvtLTA0bUiZSwkFq+9T/?=
 =?us-ascii?Q?QfrzdN8aNuNai6D+BkI3fn8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f88bb85-924c-4357-d768-08d9f5e38941
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 09:13:05.7404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qabJi2tmSF2IpFQFqhlxpoDHmts+G9Hgaj1KgUKlJxLUov4Bn1AfOkq8ZMYzBeqFXxFOy45r1Tgt0zLbtt3cbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Tuesday, February 22, 2022 4:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add mode2 reset support for smu 13.0.5

This patch adds mode2 reset support for smu 13.0.5.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index 74e0550d00bd..80caf73bc2ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -454,6 +454,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 5):
 		return AMD_RESET_METHOD_MODE2;
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 11):
--
2.25.1
