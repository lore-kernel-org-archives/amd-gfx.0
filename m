Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A97FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 15:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2F510E29F;
	Mon, 11 Apr 2022 15:25:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A4C10E29F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 15:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJXHsuBGNoBBQDpvBRTKa98QvVGvtDv2vcBUPKOu4e0AqnO5VY0bC2FsqtCO5mGj1rdKWzq5zgufCrISym5jXGqSbgH1s9+WvnSGoXkUX2EyGbycFGKcgFmaeedezmrTAPJ+wrUPlMzfRd1bPJ/ZxgRkLkdJl41HdzQx9NGRlDiCDQCE6S0Y1AmrYi1V4dc6EEgP0ruFi0hVc70KfpQBwcvQE022ReZFC0olFwjSOdAuno2lQiBNhfIe6zivdy0k4VTMymTq/lB8ta9AxAVeVTT4cMW5t0XYZDvWvZlwGndyEyxhvF2YmqjM5mLLEXw65pcTS/Hne6cSRbYspmjLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTjBtY5C9AGB8L4O+FB2v+MX+8aY9ZwhMRjO38LE5+M=;
 b=PCwjgwZ4f3WJEku4WtV0xWnyVhNxA8Xlk/pOqsrlyzNiZfwYERn/zJX+2AnEhmI4Vicocov1+65C8xXoEbVduikEytJr7I+H/NFQqNK6WwuIzP4zXcjn2pACUtBZS8nzU1YXWJKQUWjW1DR0sj4oORsghWD2j0Qz8NUbHAraHDiVGM1TaNUY5ufUiMu3jP/pJ9/YPSzmHBqdimf6YgcLjcvHmKLzl13kFdARKDvePuyefqgJOJLtUVXNMsWCARnFYPFkbMRjAgsnxVsJAZ+pe51CPN2ipytdVX4fxKV4hAijojLRKnehA2qN2BppsW4+Gsnbwjwaxv8i6mUvdwIJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTjBtY5C9AGB8L4O+FB2v+MX+8aY9ZwhMRjO38LE5+M=;
 b=hdzBbIHwdzmF4tYcD/QDMZkHvhmCGqMANowcCTum5eiuBXUGNUizwgCVgAJt5tiVo/UcBPX5/d/XuQ26qdupbF2vk0hPF3OPH8AaXUZxwjI8wHwjexU3Dj8z58CeHzbDx5zHU62KFqAAYe5TgpQp5w2Bg4EMXOOyJV+I5mhNUsY=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 15:25:05 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::610b:3e61:665b:cdc4]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::610b:3e61:665b:cdc4%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 15:25:05 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 ] drm/amdgpu:  fix discovery ip failed 
Thread-Topic: [PATCH v2 ] drm/amdgpu:  fix discovery ip failed 
Thread-Index: AdhNuE6ZHW5TzAfPRgeHRolpuBGgOQ==
Date: Mon, 11 Apr 2022 15:25:05 +0000
Message-ID: <DM4PR12MB51523E7DEF46C4D62472DFF1E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-11T15:10:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=48c60490-b801-42d0-b0aa-6f9638850e7c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-11T15:25:01Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 3478d744-fcc1-4709-be55-97e782f1e481
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28f949fd-f4ca-496c-d35a-08da1bcf7475
x-ms-traffictypediagnostic: MN2PR12MB4567:EE_
x-microsoft-antispam-prvs: <MN2PR12MB456704FE26FE44D391E57850E3EA9@MN2PR12MB4567.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VStP5slVv8swPVzxandTUVYf8u3jC4/Z4W1tN4cQjrzoTuSPZPr+atdLg6mqkJNkTSSfEozm0nhYfs9DDdGOP9ykB4H5NaNeNvDx3fqd/sJFVG4GXzqjsJiKNp0MmVKJ3YcTeEsC9ZbPXU58pnmSoc4Fmjv+tW0QCIQj8lwHTa1tMClMPFT0IOcg173lEAZxPLYHMGlRq/lFsqtcVyQg57i6ioYXQVQpYGR1TtpwQD+YypADtGf6rQJOCVYobmOWjvkJ0v7H7IJiSS+CcAKc8ZRx/K35XBwiYWb0NY7GPBV6V72s6wG2n2oEsnmqVWd/ZQk7vbhYTk73E1PWWP57R2WsGUS7HEceG51Dh7tAZzn9X/XnQO/trUJyDublBnjv7xFPKAwkVmm5OsAiLCDfvejhOaV0SMPLGjDGaewoqKNtgYjlwteISOaLYPlNJ468FjHgsm4OpbJ4QZdYQrl8dci5owUXxIJweEXQBlB9HweothpIpeNNiKSjsTJ2lFEoT5eP2bnF4WhJHfnhi48YZMlcwM67E40OwQM+H/Ul4YL+f3cihGRAskjXIKTAEgWAOT1N9tMXCQwSKUuwGRXGjoocuaQV5iO9cAnRgKXBkAzHtkRS2CKu6s2/1s6i9pksNyLkgj6kker5mRtk/pOd6WJuumIF6K1hvB6oFHT+0h8sdfcdf6L3/lKfp9cHxZBo71HHGBhavsXsphxRfP24ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(52536014)(33656002)(54906003)(38100700002)(8936002)(2906002)(122000001)(9686003)(5660300002)(4743002)(316002)(38070700005)(66476007)(53546011)(7696005)(26005)(6506007)(6916009)(186003)(71200400001)(508600001)(55016003)(66946007)(66556008)(66446008)(64756008)(4326008)(8676002)(76116006)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zxpunTwzNYPjVdzcMArV60O/xaZjpl0PmyglSTFdnUg0NfBTVQI0uAEB+D2J?=
 =?us-ascii?Q?FZ0fy8w2ltpykj7i+eDNbIC5Ez+Ys9gFzwxEGdKCjQFQgKSrd6qBJZWKqEFz?=
 =?us-ascii?Q?E3PRjfh+AB2ew5g7KFpKzEO661xx2moos3CnxPuJm90CGbgzU5qMift0j5cW?=
 =?us-ascii?Q?LjX58lwr76kQ9RSe+jLGakno1P6Vg2BpvJOJa0/7KUZ/N6TNeq2R30/C1BmC?=
 =?us-ascii?Q?h0mF70q9Zt4Q2eHU5W3nDjeD/3FJkFBZUG/U86aioPkazI7Oz30T4tjRBY5r?=
 =?us-ascii?Q?dniTuk+TsydtuI3vjiqK46TCNuxH5S2bDLEuAeVPrUxKmJpX4s/Od7t0DoPn?=
 =?us-ascii?Q?PuPiK1GsIZKOETUw1y+KekK/nxxAnUF2n0mXMYkQPsi2vanyoRoeRTB0m9j9?=
 =?us-ascii?Q?TSA1xpGPNOZnnS+quKmrVWSyXNvBuggCTWclhZo+i0OReRVbwFD3qmB7OVzr?=
 =?us-ascii?Q?j4JWSwbfL4oV6xzB6gqLO9v90GBn/4Lap178jOzVLGXW7KhKLbEWvVCjC+mc?=
 =?us-ascii?Q?cIhcGa7zQO2/IDbZ3cG79HPGkzfihMsvmOQiL93S6o9UNVT7nGYWdMChIpDr?=
 =?us-ascii?Q?JxT2/kMh35fRBCSEzzDrjl02dvRxweoz9j41zHys8OsHaVjv4idZ3LFpgVy3?=
 =?us-ascii?Q?YuHsRBormBgrniCh2zYJuWTkVoy3VNbjEIB6YWm9/C/BXWR5qiR3inxVG4+O?=
 =?us-ascii?Q?4batnd3XvRPxL8J3x7Yoft/JWM6m9qnmowODRtVrugv2IBDwpfimSc/ZQnVX?=
 =?us-ascii?Q?b0ffcwOeWI3ns5st+5BnnPg2Dvg9D/Q9m5JmwhynM68hZuoW9nwi3nSGt4Hq?=
 =?us-ascii?Q?8XS156kCs6KbgL244d8DntzkqTVKY7Usj9FzRRC0QoUnn4vJuqpZShE+7yAw?=
 =?us-ascii?Q?GS9NUBB1/liuGs8oAlCS4g/5HcQPlqweBIDPJ4ieTxRefMVC//HsGzxOj12O?=
 =?us-ascii?Q?Im2UIy33t3lQ8kf6hTBd1y4WscSuXC9qu2EpWZ9I1X7QTmeNuzq4f60LtKzC?=
 =?us-ascii?Q?mVUQaU7pTYZYpd+lYfk9iPk+2I+Wa0FYs9gayproop3B91o+DfKSbnF2vc96?=
 =?us-ascii?Q?3wm2l+qQ5G5qEJX4PVJh960Qzq6pD0zf/ApfydcAch99LLHo2bcvSZVyohLu?=
 =?us-ascii?Q?a05sm4CDaCnwSjYmxuOFvxM6hDVrIxNrJ5Tpshm7zD03UDJTudo3APppLRzP?=
 =?us-ascii?Q?Cgy/sHeel+b3HpzQYnUsO2BSyC7SJ2+WfOlmOtCTIxcOLyKy7vKzUT73TJ1t?=
 =?us-ascii?Q?79Btig4BLmpSe5dVRh8D263W8toIhi12gFJULfL2zwCZmA5UpXHM7I5TKeJ9?=
 =?us-ascii?Q?v60yv1IBP08tB78qD8WyJKL7v7d7B4sZruTJugLkUfMADgIQ8CMKdw7xWCO6?=
 =?us-ascii?Q?nRwImDT25mp2+9R583P4Xl3K4oMnLGuGjG6Utxa6razc6T4AG4btAoG/Uego?=
 =?us-ascii?Q?MQ5wSYoVJZAbZPww3e2JG/jBX3WU8okMu/qnJ118vrysXmaSeMXwJnsCGLam?=
 =?us-ascii?Q?C9T1vsh1q76Ynv4MaPouuM1smS/Cb9VNDCidGghOjx4X9GGxKbLT2u8slpCu?=
 =?us-ascii?Q?kZ623hkJqN/IyVLas/qiDxOMBQEkIqbiJCVTfrsKJAr2zcc3Z1yyJ6KTbP7E?=
 =?us-ascii?Q?9NDgikG6qOTduU/UhQNaOHXXTS62n3WXV4BemDxOeCBfyf7aJvZtSgvcosEf?=
 =?us-ascii?Q?FPWT3x3kC7dLkC0K7cCgLHvwD7W3sdmBDBC2/UaUHvOMM80znO19c35VC6gb?=
 =?us-ascii?Q?9O/hPinOKA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB51523E7DEF46C4D62472DFF1E3EA9DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f949fd-f4ca-496c-d35a-08da1bcf7475
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 15:25:05.1468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KGh0GxIiMzjA9eZVZeqjNYS49yMgijWT9px+c5DvUzVLuFoaaUYvGid2ow9fjrKEJEpMYrP1sUpcMxf/aWDMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB51523E7DEF46C4D62472DFF1E3EA9DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

+ Deucher, Alexander

From: Zhang, Jesse(Jie)
Sent: Monday, 11 April 2022 11:15 pm
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH ] drm/amdgpu: fix discovery ip failed


[AMD Official Use Only]

Fix discovery ip failed, and the log:
   56.129549] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpecte=
d number_instance (64) from ip discovery blob
[   56.130129] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed hw_id (45056) from ip discovery blob
[   56.130701] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed number_instance (66) from ip discovery blob
[   56.131283] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed hw_id (45568) from ip discovery blob
[   56.131855] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed number_instance (66) from ip discovery blob
[   56.132436] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed hw_id (480) from ip discovery blob
[   56.133053] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed hw_id (608) from ip discovery blob
[   56.133626] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed hw_id (640) from ip discovery blob
[   56.134207] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed number_instance (64) from ip discovery blob
[   56.134780] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed number_instance (64) from ip discovery blob
[   56.135360] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpect=
ed hw_id (28672) from ip discovery blob

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 766006a075ec..a778b0392e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -798,7 +798,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_dev=
ice *adev,
                        res =3D kobject_add(&ip_hw_instance->kobj, NULL,
                                          "%d", ip_hw_instance->num_instanc=
e);
next_ip:
-                       ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_addr=
ess - 1);
+                       ip_offset +=3D struct_size(ip, base_address, ip->nu=
m_base_address);
                }
        }

@@ -1063,7 +1063,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_devi=
ce *adev)
                        }

next_ip:
-                       ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_addr=
ess - 1);
+                       ip_offset +=3D struct_size(ip, base_address, ip->nu=
m_base_address);
                }
        }

@@ -1113,7 +1113,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_dev=
ice *adev, int hw_id, int n
                                        *revision =3D ip->revision;
                                return 0;
                        }
-                       ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_addr=
ess - 1);
+                       ip_offset +=3D struct_size(ip, base_address, ip->nu=
m_base_address);
                }
        }

--_000_DM4PR12MB51523E7DEF46C4D62472DFF1E3EA9DM4PR12MB5152namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:-apple-system;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0cm"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+ Deucher, Alexander<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Jesse(Jie) <br>
<b>Sent:</b> Monday, 11 April 2022 11:15 pm<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Zhang, Yifan &lt;Yifan1.Zh=
ang@amd.com&gt;<br>
<b>Subject:</b> [PATCH ] drm/amdgpu: fix discovery ip failed <o:p></o:p></p=
>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0cm"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fix discovery ip failed, and the log:<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:-apple-s=
ystem;color:#172B4D;background:white">&nbsp;&nbsp; 56.129549] [drm:amdgpu_d=
iscovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from=
 ip discovery blob</span><span style=3D"font-size:10.5pt;font-family:-apple=
-system;color:#172B4D"><br>
<span style=3D"background:white">[ &nbsp; 56.130129] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected hw_id (45056) from ip discovery bl=
ob</span><br>
<span style=3D"background:white">[ &nbsp; 56.130701] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected number_instance (66) from ip disco=
very blob</span><br>
<span style=3D"background:white">[ &nbsp; 56.131283] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected hw_id (45568) from ip discovery bl=
ob</span><br>
<span style=3D"background:white">[ &nbsp; 56.131855] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected number_instance (66) from ip disco=
very blob</span><br>
<span style=3D"background:white">[ &nbsp; 56.132436] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected hw_id (480) from ip discovery blob=
</span><br>
<span style=3D"background:white">[ &nbsp; 56.133053] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected hw_id (608) from ip discovery blob=
</span><br>
<span style=3D"background:white">[ &nbsp; 56.133626] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected hw_id (640) from ip discovery blob=
</span><br>
<span style=3D"background:white">[ &nbsp; 56.134207] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from ip disco=
very blob</span><br>
<span style=3D"background:white">[ &nbsp; 56.134780] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from ip disco=
very blob</span><br>
<span style=3D"background:white">[ &nbsp; 56.135360] [drm:amdgpu_discovery_=
validate_ip [amdgpu]] *ERROR* Unexpected hw_id (28672) from ip discovery bl=
ob</span></span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 766006a075ec..a778b0392e9f 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<=
o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<=
o:p></o:p></p>
<p class=3D"MsoNormal">@@ -798,7 +798,7 @@ static int amdgpu_discovery_sysf=
s_ips(struct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; res =3D kobject_add(&amp;ip_hw_instance-&gt;kobj, NULL,<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%d&quot;, ip_hw_instance=
-&gt;num_instance);<o:p></o:p></p>
<p class=3D"MsoNormal">next_ip:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ip_offset +=3D sizeof(*ip) + 4 * (ip-&gt;num_base_address - 1);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ip_offset +=3D struct_size(ip, base_address, ip-&gt;num_base_address=
);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1063,7 +1063,7 @@ int amdgpu_discovery_reg_base_=
init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">next_ip:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ip_offset +=3D sizeof(*ip) + 4 * (ip-&gt;num_base_address - 1);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ip_offset +=3D struct_size(ip, base_address, ip-&gt;num_base_address=
);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -1113,7 +1113,7 @@ int amdgpu_discovery_get_ip_ve=
rsion(struct amdgpu_device *adev, int hw_id, int n<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *revision =3D ip-&gt;revision;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;return 0;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ip_offset +=3D sizeof(*ip) + 4 * (ip-&gt;num_base_address - 1);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ip_offset +=3D struct_size(ip, base_address, ip-&gt;num_base_address=
);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB51523E7DEF46C4D62472DFF1E3EA9DM4PR12MB5152namp_--
