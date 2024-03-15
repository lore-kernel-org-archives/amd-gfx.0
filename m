Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B814C54E67
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 16:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 034D6112357;
	Fri, 15 Mar 2024 16:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="btmr0ymH";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6218411221B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 15:26:18 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso1164872f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710516376; x=1711121176; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YaYrSpOckt716kWLIWQKm3OppZY/2t/QcB9ou2RNxFs=;
 b=btmr0ymHfzbwl7h5MbGA1JWYulSORPSgTEHHxuXkEW2rNkVpdM75k9nwt9+PAw9bVr
 JXHZlJ8XXKINnM+qZ+VsMWMALRncU4Fdck82bUlkf0faJ6BWZQaejWwWAQYwFLe5kbhM
 61W8Vz6VYWzOtOGofTw2HSH41NCIgN/q8S91nW51KxC4E1aEM7RjxyrTzEURYzWH3M5h
 fs7EQpcZjTgaYEzyHbsS6b8smXpqf7uYQP/Qm/TBA9yVenU9di8JxXBZQK2OQt2aGH/+
 kpjpkFiPdbXfDhuoll5D5QjdgMfVWpPf9Jqh1TNgfMYMdbEVReaMHDqlwmRA80sJYk3s
 nwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710516376; x=1711121176;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YaYrSpOckt716kWLIWQKm3OppZY/2t/QcB9ou2RNxFs=;
 b=czyhGN/zq9L5VmtpCsTOAcpPO1oec5S5HzamIvCe+hPywlTUQBJ0IaaY8ao+tvZj2o
 VeeMbzFUD5J18xthEvsTMIOCcLAKnhE+8xqGfkiEK+pCibgpfqnfmDa+PZQ4RBdHewwa
 AJxVIpQqnUiqYI8D1SywvYn922IrP1ZS86BXdOvWbNYQ4OPq9J9oi6uui0ZKU0/Rfpsf
 A+/kpntPYPn8i+jg0zBFHjNmpVr0S1AM/EkzFQwQeyGr4gN4PNk4X8mCIiAr8NDYsiwZ
 N2GzsaM7AhwOXWRu2NgIQCCQdOkkB5U/cRDSU2sggBHmotRjW0tGZrIU3KiGF+xUF8j0
 UgDA==
X-Gm-Message-State: AOJu0YyJllQNLv9Q5kqUSK5EpqCvpae22m15mkNCYqiUqF72G28rxHVO
 XZZJQB07nej/6MwBO0wpPmdKH5Us//1OotR4MYxBFOkvYsEYrOwUG1tKIGvy6mo=
X-Google-Smtp-Source: AGHT+IFF5uqlmyrTxw34wmMSKcj0yjMLnHk5yjNQC+z23LSo5AiPIQ3hNVJyoYxoGGncOjK9lrJUJw==
X-Received: by 2002:adf:a395:0:b0:33e:1f2a:d88a with SMTP id
 l21-20020adfa395000000b0033e1f2ad88amr3635419wrb.69.1710516376345; 
 Fri, 15 Mar 2024 08:26:16 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 s15-20020adfeccf000000b0033e9e26a2d0sm3411152wro.37.2024.03.15.08.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:26:15 -0700 (PDT)
Date: Fri, 15 Mar 2024 18:26:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: nicholas.kazlauskas@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amd/display: Add debug counters to IPS exit prints
Message-ID: <9855fbc4-344c-41b1-b767-d4f0b71b88a0@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 15 Mar 2024 16:22:14 +0000
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

Hello Nicholas Kazlauskas,

Commit 2dfaea1d715a ("drm/amd/display: Add debug counters to IPS exit
prints") from Feb 21, 2024 (linux-next), leads to the following
Smatch static checker warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:1398 dc_dmub_srv_exit_low_power_state() error: uninitialized symbol 'ips1_exit_count'.
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:1398 dc_dmub_srv_exit_low_power_state() error: uninitialized symbol 'ips2_exit_count'.
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:1398 dc_dmub_srv_exit_low_power_state() error: uninitialized symbol 'rcg_exit_count'.

drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c
    1279 static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
    1280 {
    1281         struct dc_dmub_srv *dc_dmub_srv;
    1282         uint32_t rcg_exit_count, ips1_exit_count, ips2_exit_count;
    1283 
    1284         if (dc->debug.dmcub_emulation)
    1285                 return;
    1286 
    1287         if (!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub)
    1288                 return;
    1289 
    1290         dc_dmub_srv = dc->ctx->dmub_srv;
    1291 
    1292         if (dc->clk_mgr->funcs->exit_low_power_state) {
    1293                 volatile const struct dmub_shared_state_ips_fw *ips_fw =
    1294                         &dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_FW].data.ips_fw;
    1295                 volatile struct dmub_shared_state_ips_driver *ips_driver =
    1296                         &dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_DRIVER].data.ips_driver;
    1297                 union dmub_shared_state_ips_driver_signals prev_driver_signals = ips_driver->signals;
    1298 
    1299                 rcg_exit_count = ips_fw->rcg_exit_count;
    1300                 ips1_exit_count = ips_fw->ips1_exit_count;
    1301                 ips2_exit_count = ips_fw->ips2_exit_count;
    1302 
    1303                 ips_driver->signals.all = 0;
    1304 
    1305                 DC_LOG_IPS(
    1306                         "%s (allow ips1=%d ips2=%d) (commit ips1=%d ips2=%d) (count rcg=%d ips1=%d ips2=%d)",
    1307                         __func__,
    1308                         ips_driver->signals.bits.allow_ips1,
    1309                         ips_driver->signals.bits.allow_ips2,
    1310                         ips_fw->signals.bits.ips1_commit,
    1311                         ips_fw->signals.bits.ips2_commit,
    1312                         ips_fw->rcg_entry_count,
    1313                         ips_fw->ips1_entry_count,
    1314                         ips_fw->ips2_entry_count);
    1315 
    1316                 /* Note: register access has technically not resumed for DCN here, but we
    1317                  * need to be message PMFW through our standard register interface.
    1318                  */
    1319                 dc_dmub_srv->needs_idle_wake = false;
    1320 
    1321                 if (prev_driver_signals.bits.allow_ips2) {
    1322                         DC_LOG_IPS(
    1323                                 "wait IPS2 eval (ips1_commit=%d ips2_commit=%d)",
    1324                                 ips_fw->signals.bits.ips1_commit,
    1325                                 ips_fw->signals.bits.ips2_commit);
    1326 
    1327                         udelay(dc->debug.ips2_eval_delay_us);
    1328 
    1329                         if (ips_fw->signals.bits.ips2_commit) {
    1330                                 DC_LOG_IPS(
    1331                                         "exit IPS2 #1 (ips1_commit=%d ips2_commit=%d)",
    1332                                         ips_fw->signals.bits.ips1_commit,
    1333                                         ips_fw->signals.bits.ips2_commit);
    1334 
    1335                                 // Tell PMFW to exit low power state
    1336                                 dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
    1337 
    1338                                 DC_LOG_IPS(
    1339                                         "wait IPS2 entry delay (ips1_commit=%d ips2_commit=%d)",
    1340                                         ips_fw->signals.bits.ips1_commit,
    1341                                         ips_fw->signals.bits.ips2_commit);
    1342 
    1343                                 // Wait for IPS2 entry upper bound
    1344                                 udelay(dc->debug.ips2_entry_delay_us);
    1345 
    1346                                 DC_LOG_IPS(
    1347                                         "exit IPS2 #2 (ips1_commit=%d ips2_commit=%d)",
    1348                                         ips_fw->signals.bits.ips1_commit,
    1349                                         ips_fw->signals.bits.ips2_commit);
    1350 
    1351                                 dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
    1352 
    1353                                 DC_LOG_IPS(
    1354                                         "wait IPS2 commit clear (ips1_commit=%d ips2_commit=%d)",
    1355                                         ips_fw->signals.bits.ips1_commit,
    1356                                         ips_fw->signals.bits.ips2_commit);
    1357 
    1358                                 while (ips_fw->signals.bits.ips2_commit)
    1359                                         udelay(1);
    1360 
    1361                                 DC_LOG_IPS(
    1362                                         "wait hw_pwr_up (ips1_commit=%d ips2_commit=%d)",
    1363                                         ips_fw->signals.bits.ips1_commit,
    1364                                         ips_fw->signals.bits.ips2_commit);
    1365 
    1366                                 if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
    1367                                         ASSERT(0);
    1368 
    1369                                 DC_LOG_IPS(
    1370                                         "resync inbox1 (ips1_commit=%d ips2_commit=%d)",
    1371                                         ips_fw->signals.bits.ips1_commit,
    1372                                         ips_fw->signals.bits.ips2_commit);
    1373 
    1374                                 dmub_srv_sync_inbox1(dc->ctx->dmub_srv->dmub);
    1375                         }
    1376                 }
    1377 
    1378                 dc_dmub_srv_notify_idle(dc, false);
    1379                 if (prev_driver_signals.bits.allow_ips1) {
    1380                         DC_LOG_IPS(
    1381                                 "wait for IPS1 commit clear (ips1_commit=%d ips2_commit=%d)",
    1382                                 ips_fw->signals.bits.ips1_commit,
    1383                                 ips_fw->signals.bits.ips2_commit);
    1384 
    1385                         while (ips_fw->signals.bits.ips1_commit)
    1386                                 udelay(1);
    1387 
    1388                         DC_LOG_IPS(
    1389                                 "wait for IPS1 commit clear done (ips1_commit=%d ips2_commit=%d)",
    1390                                 ips_fw->signals.bits.ips1_commit,
    1391                                 ips_fw->signals.bits.ips2_commit);
    1392                 }
    1393         }

variables uninitialized on else path

    1394 
    1395         if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
    1396                 ASSERT(0);
    1397 
--> 1398         DC_LOG_IPS("%s exit (count rcg=%d ips1=%d ips2=%d)",
    1399                 __func__,
    1400                 rcg_exit_count,
    1401                 ips1_exit_count,
    1402                 ips2_exit_count);

used here

    1403 }

regards,
dan carpenter
