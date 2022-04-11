Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAABC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 15:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6641910E074;
	Mon, 11 Apr 2022 15:15:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6862C10E074
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 15:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExWWgGbrZ4RiB+w54+4Fo7yomxC75EYEcKucjAh8LMbsg+lzH9OPlcrH+UmBpLhkCmBK9ap/F78TrMAHgHVGi28J+4fEkcR1wXA9q8Joq8mmSedd052drFHDg7e50AqkhyQT7bm2gI98Pb+lWxsIDFSntDuNJU/ucR4XaJVwtF/rWx+QhJa+Rgifgco+nTfrsa/sfB/H4KzJZlsW6FzSu5bimcwM2BswIQMgF7d6KTBdzScWK+6BsFJybylZfE085hbW/IHEVv4cFBBwsaHsbiv4ezvCMxnym7Z94UY2NABQem+rN9Y0BmrITEet0Lx4HGRWoLiRyEJJvXmI1m9lCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7ZMZ8oJWVb0saadd81ocJA7dT3AVxZUKMG8Lmkq3Gg=;
 b=R+no5L/O1tCD37MJCqtAXrCbn4hMRMoBIcwdwBK9kt1Orqd6Q1X1q2aerdaqsYjCVMEbd/RusYjCGzh3VMACRiMnVbqJKXxZVv1yFFYZgNU9NVFrP8qvOJ8E+lFAfuR3msY92O93AHmNM81cYnb3iHdpZGGpwtbWsfo+r9dMYdoiNwf+3UaLZeoUZAE2iBHecs9TRNpBNBD4wk3zo1+ehUjGrHuyLdJeKz0wd23ksd4s/CJhbQRwpnunVP2HRedTImH35UNe6g0dZuwpXVQ2fbuzYjN+mYwVcvE7rqm+9ilhvon7gZmeqCesg29WANyLVHAJdzwsnMCNO1M7aiUz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7ZMZ8oJWVb0saadd81ocJA7dT3AVxZUKMG8Lmkq3Gg=;
 b=LFJ3BPo7AgbsJZubJnv+CGSLAIU8bRMAlHR24Giqu4GrRBMiZ3JKsT+rzuA4+GOqJkbr7DSSY6124zHbcJojgn4wCkc+bYfzjwR9s2D9LyIPr97piWPycXqUaOXZNGPWwMsslsUtIyIjA8z8R2d6D7WQugr3KpC3MtV86uw36gg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 15:15:25 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::610b:3e61:665b:cdc4]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::610b:3e61:665b:cdc4%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 15:15:25 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH ] drm/amdgpu:  fix discovery ip failed 
Thread-Topic: [PATCH ] drm/amdgpu:  fix discovery ip failed 
Thread-Index: AdhNtvY3qJYvfOF7T1Cc3PFgT0as1g==
Date: Mon, 11 Apr 2022 15:15:25 +0000
Message-ID: <DM4PR12MB51525F878057240AE5C91F14E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
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
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-11T15:15:21Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 01a3b2d7-b001-4331-a43f-4d88cf96f84f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ea0ae5f-ebf0-4888-cc24-08da1bce1b14
x-ms-traffictypediagnostic: BL1PR12MB5320:EE_
x-microsoft-antispam-prvs: <BL1PR12MB53208672DA10968149922F02E3EA9@BL1PR12MB5320.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8zf9WVi2L6hHCacujOH8a1WMHZ1ehpF1LqzmbMPX7I3GUMOi0xp/NaPRjlxMBPJOZiPGIoIfeydGyOxmDQsz4rOEmbOoPzldvsO+VTWpf02HW6HRucmc9aL1gR0pMxwB3Ze3H3QvuBf2ZGNVOLdeboJ26WWbndYgPKFqFrx16daJ/A1rw4+cAU6KQ3LSLtHhaql2tpTSXTXnP+nquxRECtbGwhpYzYY8xQDqnPWugwVhTv+vrTiJtBAcNEVyUhCr8uNDH6Q6QFynFoycsgx53XorzeEIvrsf3xn9mZ0yA+D7M9MMu2xVAWYXXoY04bEyoq/nlqHSuKgGeu2gHPqLR65u930xOhlJABMO+scCywuwMaeGCtGM41UK6jDyksfsWYRSniUjdYd6Zz7BmBC6kPNroOOm1pWt++kcDp3aX1/v1cqdPfPvAjF2LuohiWwbi25giYO59Eggknep0GTgLId5wD1GFlzotd81TrequW5kDUfWrMM9t6e0ockJYSfZVPdf/Pvl3bxwwpw1ImszDwHHh0VH0W3IHJdtn02S9P0lwXggWOIxazerDMMq3OMGjaPaBBw4QNuRAd1NWCzzxYdKIqyuWmniOmrSw20v/JG22q14HoJxvokfKGK9LcViAVl+tIWY3Q4DIeyx7d29i5GfLcjWxLAJuosW2tTyjLLKEqE3+KsiqdhHhD4zCT1CYyylfQgd9DqbtumobQ+u8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4743002)(66946007)(66556008)(316002)(66476007)(76116006)(8936002)(71200400001)(66446008)(54906003)(5660300002)(6916009)(8676002)(64756008)(9686003)(6506007)(4326008)(7696005)(508600001)(26005)(83380400001)(186003)(52536014)(33656002)(86362001)(38070700005)(38100700002)(122000001)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TPcueCIXKE8hC5ixOP71/CWXlFcfyg6M5sk8yxloQHUaoTBWh7O7SdWTQKfA?=
 =?us-ascii?Q?JKTE9WXzVxwnEspu09/8+TxegINvyx4tIKL0ZQp9T4zXovjD7aSJDfqO51rl?=
 =?us-ascii?Q?Gs66M5KV/xt0eNxhsQ8gbvysDpxtBwWyq1XYCr1iUKfMthVgv2cudvBZtDjq?=
 =?us-ascii?Q?PibCrSPLYmki2cG9EUXysU3kr0CVAj8ZyYqxvM2kf3bXwHJr8WvyPEu7VdSQ?=
 =?us-ascii?Q?1fg63uAS2b5hmY+qE0cCc+WCxsnLqUnkdZY4W0XD2HFYL3KP8XmOy84Qh2B5?=
 =?us-ascii?Q?hg9L4l3dq5+pAulR6oDPqgdAHpbEBisidh2SC2/gHN8a27pkWZqTXd6l8XsO?=
 =?us-ascii?Q?lvZxzgFO+1RX+gj7vTXK53O68C1rH3QMggYcfy4WoXUp56DxXqum2KO8CaGA?=
 =?us-ascii?Q?u9pMG7PQ86+08rnfgu9wzq04NpreuLkx7K4t9ka55j7Ky9ZqTqBMZ5NSLc3c?=
 =?us-ascii?Q?pKsULi7ivL9wdKmz7GZ7k2MFYLcP4eRmA1B5WaUbU1D6COUKD+HEc1oGq/Do?=
 =?us-ascii?Q?r6/oaItkemxtE83PvV8RNLDEuAp0AbXvSm/Tlg01USKuElJu10JEvhs+A8ct?=
 =?us-ascii?Q?Qs9VIqs26ORC6pLtZ6XSMfEUL+3PzGmlXtzdCRowfhpsX8WtyvZ5EaEls9Bk?=
 =?us-ascii?Q?GK8Om6a6wdciet73n7hAQ5eVpYkaL0HfYO402OiTxBdZ425cu347ZM+fK+Ji?=
 =?us-ascii?Q?dz01AuBK37E9O+URcMoQEBjA4iS9LfchDalkJqqbs5MYkyVoN9Di+uEtCG4p?=
 =?us-ascii?Q?TGKuXa6bYgEZSUPdi/LdbUsAzOwy3SrGC5tdJkOGsae8isJ39rOSt0gLchvI?=
 =?us-ascii?Q?ez358H+yWapu1iPtH+szOu9tH03ZO7PhHE9rmldda8R8Ln7gIO1h7YHX5bx2?=
 =?us-ascii?Q?ErorOiZR/qO7CD99DwQZUUXRu/SrjFX43kyS3ZhCfUkfkzMUi4Y9rYdvLa+W?=
 =?us-ascii?Q?aqTqZvkOeUoC9ncyzTD6GoZ7iZkFLLW+HDlob9TpejxRaq991opdRQOMZJGL?=
 =?us-ascii?Q?QIxaxuZEmRHJPpQvi150ajuv65V9sCrNLTaHobZpIZ7r5tcKkW/MD8wQw0mD?=
 =?us-ascii?Q?ZuefZz4I2CPaIxODn3OUmg0iGsKxmb0flVbb1+07YBEwWUQJ1Ub+2dvyMMpU?=
 =?us-ascii?Q?OWLIyMy4amdPBFKV/YgQhB/2Ieuz3RzjN5BBnlID4CmEMR9IH+Q1KamVU+t2?=
 =?us-ascii?Q?9zc133bEvlQC9zzoukwKAmhKv7fkPS2a+IPLuKXaZxqhpGVxO37BkDxrag5u?=
 =?us-ascii?Q?0QeZT3U1MAqDiJW6oEfLjIQf6sd8VksDzy6S10gHhY94xjMKXem6feyJlcle?=
 =?us-ascii?Q?q2nM7sp5KLAa17rI/jp9tKJeLnTnO+U9KW2l5PsbTKblDbFTssITvw9h7Lia?=
 =?us-ascii?Q?fWEoW6a2lHYFsudtjFSZiv3CeKplQUMvZasbY5nGFWPJ9Pe7LYvD8cBSBECm?=
 =?us-ascii?Q?61SlMA9SKndZrDk8fAHvbZjtIUma3ocIIiK861VuYNiXEISCoT/qUdQbNPRw?=
 =?us-ascii?Q?sj9aeSGjWKxKKqtBRrMewAViJr/XpbclN6ODU98ada9T3gbIjrd/Gc1Zav9r?=
 =?us-ascii?Q?gp4XmqUYiJhlgOC4Eq/MM8MdsyE1WbwQi0Bubqie5ElVg6hEzsmp3D+EQYPQ?=
 =?us-ascii?Q?7QEIrso/H/px+qnryWUBiR0IEpzVw0IaiefgtZwITQ+y0Mcv2DTa4W2zoXIj?=
 =?us-ascii?Q?gV7IAgXPK028oJNeWNnW0UnSlgguH+8jlQld8vheJ40zz0A/rvCrJCDdFo4E?=
 =?us-ascii?Q?5DAYWT9JEg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB51525F878057240AE5C91F14E3EA9DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea0ae5f-ebf0-4888-cc24-08da1bce1b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 15:15:25.6657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PK9r6aalQvmANjvJsTmzEC4zZcrMT8DardeXywiEuplUHniAUTxilDH4rp3iaph1MZojG5APUz6MBtO42kMrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB51525F878057240AE5C91F14E3EA9DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_DM4PR12MB51525F878057240AE5C91F14E3EA9DM4PR12MB5152namp_
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
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

--_000_DM4PR12MB51525F878057240AE5C91F14E3EA9DM4PR12MB5152namp_--
